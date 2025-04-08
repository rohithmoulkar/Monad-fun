// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IWMonToken {
    function transferFrom(address from, address to, uint256 value) external returns (bool);
    function transfer(address to, uint256 value) external returns (bool);
}

contract WishingWell {
    struct Wish {
        address wisher;
        string message;
        uint256 wmonDonated;
        bool granted;
    }

    address public admin;
    IWMonToken public wmon;

    mapping(address => Wish) public wishes;
    address[] public wishers;
    mapping(address => uint256) public grantedToday;
    mapping(address => uint256) public lastGrantDay;

    uint256 public totalWMONReceived;

    constructor(address _wmon) {
        admin = msg.sender;
        wmon = IWMonToken(_wmon);
    }

    /// @notice Make a wish by donating WMON
    function makeWish(string calldata message, uint256 wmonAmount) external {
        require(bytes(message).length > 0, "Message required!");
        require(wishes[msg.sender].wisher == address(0), "Wish already made");

        require(wmon.transferFrom(msg.sender, address(this), wmonAmount), "WMON transfer failed");

        wishes[msg.sender] = Wish(msg.sender, message, wmonAmount, false);
        wishers.push(msg.sender);
        totalWMONReceived += wmonAmount;
    }

    /// @notice Grant someone else's wish and get their donated WMON
    function grantWish(address wisherAddress) external {
        require(wishes[wisherAddress].wisher != address(0), "No such wish");
        require(!wishes[wisherAddress].granted, "Already granted");
        require(wisherAddress != msg.sender, "Cannot grant your own wish");

        // Grant limit logic
        uint256 today = block.timestamp / 1 days;
        if (lastGrantDay[msg.sender] != today) {
            grantedToday[msg.sender] = 0;
            lastGrantDay[msg.sender] = today;
        }
        require(grantedToday[msg.sender] < 3, "Limit 3 grants per day");

        wishes[wisherAddress].granted = true;
        grantedToday[msg.sender]++;

        // Transfer WMON to granter
        require(wmon.transfer(msg.sender, wishes[wisherAddress].wmonDonated), "Transfer to granter failed");
    }

    /// @notice Admin can withdraw leftover WMON
    function withdrawWMON() external {
        require(msg.sender == admin, "Only admin");
        uint256 balance = address(this).balance;
        require(wmon.transfer(admin, balance), "Transfer failed");
    }

    /// @notice View a specific wish
    function getWish(address user) external view returns (Wish memory) {
        return wishes[user];
    }

    /// @notice View total WMON ever received
    function totalWMONReceivedView() external view returns (uint256) {
        return totalWMONReceived;
    }

    /// @notice Number of wishes ever made
    function totalWishes() external view returns (uint256) {
        return wishers.length;
    }

    /// @notice Get list of all wishers
    function getAllWishers() external view returns (address[] memory) {
        return wishers;
    }

    /// @notice Get the last 20 ungranted wishes with full data
    function getRecentUngrantedWishes() external view returns (Wish[] memory) {
        uint256 count = 0;
        uint256 len = wishers.length;
        uint256 max = len > 20 ? 20 : len;

        Wish[] memory result = new Wish[](max);

        for (uint256 i = len; i > 0 && count < max; i--) {
            address wisherAddr = wishers[i - 1];
            Wish storage wish = wishes[wisherAddr];
            if (!wish.granted) {
                result[count] = wish;
                count++;
            }
        }

        // Resize array
        Wish[] memory finalResult = new Wish[](count);
        for (uint256 j = 0; j < count; j++) {
            finalResult[j] = result[j];
        }

        return finalResult;
    }
}
