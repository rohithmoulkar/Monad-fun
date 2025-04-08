## 🔮 WishingWell — Monad Testnet Contract

A fun and interactive smart contract deployed on the [Monad Testnet](https://testnet.monadexplorer.com).  
Users can make on-chain wishes with WMON tokens and others can grant those wishes — earning the donated WMON in return!

These contracts are built to encourage interaction, learning, and unique transactions during the Monad testnet for fun.

---

### 🚀 Deployed Contracts

| Contract      | Description                          | Explorer Link |
|--------------|--------------------------------------|---------------|
| WishingWell  | Make wishes & grant them for WMON    | [View](https://testnet.monadexplorer.com/address/0x9fD095d0090C80b4499558695766a590D9413A92?tab=Contract) |
| WMON Token   | ERC20 token used for wishes/grants   | [View](https://testnet.monadexplorer.com/token/0x760AfE86e5de5fa0Ee542fc7B7B713e1c5425701?tab=Contract) |

---

### 🛠️ Usage

All contracts are written in **Solidity `^0.8.26`**.  
You can:

- 🔁 Fork this repo
- 🧾 Interact via the “Write Contract” tab

---

### ✨ Functions

#### 🪄 `makeWish(string message, uint256 wmonAmount)`
Make a wish by submitting a custom message and donating WMON.  
> ⚠️ Must approve WMON token transfer to the WishingWell contract before calling this.

#### 🎁 `grantWish(uint256 wishId)`
Grants the wish and receives the donated WMON tokens of specific adress.  
> Grants are only possible on unfulfilled wishes.

### 📬 getRecentUngrantedWishes
This read-only function returns a list of up to **20 most recent wishes** that are still **ungranted**. It helps users find wishes they can fulfill.








### 📌 Example Flow

1. ✅ **Visit the WMON Token Contract**  
   👉 [WMON Token on Monad Explorer](https://testnet.monadexplorer.com/token/0x760AfE86e5de5fa0Ee542fc7B7B713e1c5425701?tab=Contract)

2. ✍️ **Use the `approve` Function**  
   In the `Write Contract` tab of the WMON token, set the **spender** as the WishingWell contract address:

   spender: 0x9fD095d0090C80b4499558695766a590D9413A92
   amount: WMON	Wei (to use in function)

| WMON         | Wei (to use in functions)        |
|--------------|----------------------------------|
| `0.001 WMON` | `1000000000000000`               |
| `0.01 WMON`  | `10000000000000000`              |
| `0.02 WMON`  | `20000000000000000`              |
| `0.05 WMON`  | `50000000000000000`              |
| `0.1 WMON`   | `100000000000000000`             |
| `0.5 WMON`   | `500000000000000000`             |
| `1 WMON`     | `1000000000000000000`            |
| `10 WMON`    | `10000000000000000000`           |
| `50 WMON`    | `50000000000000000000`           |
| `100 WMON`   | `100000000000000000000`          |

   Then click `Write` and confirm the transaction in MetaMask.

3. 🌠 **Call `makeWish()`** on WishingWell  
Provide a wish message and amount:


4. 🧙‍♂️ **Someone else can call `grantWish(wishId)`**  
This grants the wish and transfers the WMON to the grantor.

5. 📬 ** click on 'getRecentUngrantedWishes' **
get : adress , message , donated wmon of ther wisher


---

### 🤝 Contributions

Want to add your own creative wish-granting logic or tweak the behavior?  
PRs are welcome! 🎉

---

### 🧙 About WishingWell

> "Where every gm can become a granted wish."  
Part of a series of simple, testnet-ready smart contracts deployed for fun, learning, and public engagement with Monad & Love.

---
