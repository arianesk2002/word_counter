# 🧮 Word Counter (Assembly)

A low-level **word counting program written in Assembly language**, designed to demonstrate text processing at the hardware level.

This project counts words in an input string by directly operating on memory and character streams without high-level abstractions.

---

## 📌 Overview

This program implements a **word counting algorithm in Assembly**, focusing on:

- Direct memory manipulation
- Character-by-character parsing
- Efficient loop-based processing
- Minimal instruction overhead

It is a practical example of how text processing can be implemented at the **machine level**.

---

## ⚙️ How It Works

The program reads an input string from memory and iterates through each character.

### Core Logic:

- Detect spaces and delimiters
- Track transitions between:
  - whitespace → word start
  - word → whitespace
- Increment counter when a new word is detected

---

## 🧠 Algorithm Idea

A word is defined as a sequence of non-space characters.

Pseudo-logic:

```
if current_char != ' ' and previous_char == ' ':
    word_count += 1
```


## 📜 License

This project is intended for educational purposes in **computer architecture and low-level programming**.
