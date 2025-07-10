# 🔍 Recon Automation Tool

![license](https://img.shields.io/github/license/imcoder44/Recon?style=for-the-badge)
![last‑commit](https://img.shields.io/github/last-commit/imcoder44/Recon?style=for-the-badge)
![issues](https://img.shields.io/github/issues/imcoder44/Recon?style=for-the-badge)

A Bash‑driven reconnaissance framework that automates common bug‑bounty and pentest recon tasks.  
It wraps **Nmap**, **Dirsearch**, and **crt.sh** lookups (with room for more) into a single, modular workflow supporting:

- multi‑domain scanning  
- interactive mode  
- selective scan modes (`nmap-only`, `dirsearch-only`, `crt-only`, `all`)  
- tidy per‑domain reports 🌐📄  

---

## 📂 Directory Layout

```

Recon/
├── recon.sh             # Main launcher
├── scan.lib             # Function library (nmap / dirsearch / crt)
├── dirsearch/           # External clone of dirsearch (see setup below)
└── README.md

````

---

## 🚀 Quick Start

### 1. Clone

```bash
git clone https://github.com/imcoder44/Recon.git
cd Recon
````

### 2. Pull Dirsearch

```bash
git clone https://github.com/maurosoria/dirsearch.git
```

Leave the `dirsearch/` folder inside the repo, **or** export its path (next step).

### 3. Install prerequisites

```bash
sudo apt update
sudo apt install nmap jq curl python3 -y
```

### 4. Make the script executable

```bash
chmod +x recon.sh
```

---

## ⚙️ Optional PATH tweak

To call `dirsearch.py` from anywhere:

```bash
export PATH="$PWD/dirsearch:$PATH"
# add the same line to ~/.bashrc for permanence
```

---

## 🏃‍♂️ Usage

| Mode           | Command                                    | Description                             |
| -------------- | ------------------------------------------ | --------------------------------------- |
| Full scan      | `./recon.sh -m all example.com`            | Runs Nmap + Dirsearch + crt.sh          |
| Nmap only      | `./recon.sh -m nmap-only example.com`      | Just ports                              |
| Dirsearch only | `./recon.sh -m dirsearch-only example.com` | Directory brute‑force                   |
| crt.sh only    | `./recon.sh -m crt-only example.com`       | Pull cert subdomains                    |
| Multi‑domain   | `./recon.sh -m all example.com test.com`   | Batch scan                              |
| Interactive    | `./recon.sh -i -m all`                     | Type domains one‑by‑one, `quit` to exit |

> **Tip:** combine `-i` and specific modes for on‑the‑fly targeted scans.

---

## 📁 Output

Each target produces a folder:

```
example.com_recon/
├── nmap          # cleaned port list
├── dirsearch     # dirsearch simple report
├── crt           # raw JSON from crt.sh
└── report        # consolidated human‑readable report
```

---

## 🖼️ Screenshots

> Replace these placeholder paths with your own images.
<img width="790" height="268" alt="Screenshot 2025-07-10 233330" src="https://github.com/user-attachments/assets/b1ff4152-8643-4e7e-a002-e627588430d9" />

<img width="803" height="414" alt="Screenshot 2025-07-10 233206" src="https://github.com/user-attachments/assets/b5f37a7c-fed6-47f8-afae-e1e0af97b066" />

---

## 🧩 Extending

* All scan logic lives in **`scan.lib`** – drop in new functions (e.g. `subfinder_scan`) and call them in `recon.sh`.
* Use `jq`, `grep`, or custom parsers to normalise tool output before appending to the master report.

---

## 🔐 Legal

Use **only** on targets you own or have explicit permission to test.
The author takes no responsibility for misuse.

---

## 🙌 Credits

* Book inspiration: *Web Hacking Reconnaissance* (NoStarch Press)
* Tools: [Nmap](https://nmap.org), [Dirsearch](https://github.com/maurosoria/dirsearch), [crt.sh](https://crt.sh)

---

## 📜 License

This project is released under the MIT License – see [`LICENSE`](LICENSE) for details.

```

### What changed vs. the previous draft?

1. **Clone URL:** now points to `https://github.com/imcoder44/Recon.git`.
2. **Badges:** added shields.io badges for license, last commit, and open issues.
3. **Username references:** switched to **imcoder44** everywhere.
4. **Minor polish:** tightened wording, clarified optional PATH step.


```
