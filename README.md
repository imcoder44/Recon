# 🔍 Recon Automation Tool

This is a Bash-based reconnaissance automation tool designed to streamline the recon phase of ethical hacking, penetration testing, and bug bounty hunting. It combines the power of tools like **Nmap**, **Dirsearch**, and **crt.sh**, and supports flexible scan modes, multi-domain scanning, and interactive operation.

---

## 📂 Repository Structure

```

recon-tool/
├── recon.sh             # Main recon automation script
├── scan.lib             # Library of scanning functions (nmap, dirsearch, crt)
├── dirsearch/           # Clone of dirsearch tool
└── README.md            # This file

````

---

## 📥 Cloning the Repository

```bash
git clone https://github.com/YOUR_USERNAME/recon-tool.git
cd recon-tool
````

---

## ⚙️ Dirsearch Setup

This tool depends on [Dirsearch](https://github.com/maurosoria/dirsearch).

To set it up:

```bash
git clone https://github.com/maurosoria/dirsearch.git
```

Then copy or move the cloned `dirsearch/` folder into this repo directory.

---

## 📌 Prerequisites

Ensure you have the following installed:

* `nmap`
* `jq` (for JSON parsing from crt.sh)
* `curl`
* `bash` (preferably GNU Bash)
* Python 3 (for Dirsearch)

To install jq (Linux):

```bash
sudo apt install jq
```

---

## 🚀 How to Run the Tool

Make the script executable:

```bash
chmod +x recon.sh
```

### 🔹 Basic Usage

Run full recon on a single domain:

```bash
./recon.sh -m all example.com
```

Scan only with **nmap**:

```bash
./recon.sh -m nmap-only example.com
```

Scan only with **dirsearch**:

```bash
./recon.sh -m dirsearch-only example.com
```

Scan only with **crt.sh**:

```bash
./recon.sh -m crt-only example.com
```

---

### 🔹 Multi-domain Scan

You can scan multiple domains in one go:

```bash
./recon.sh -m all example.com example2.com
```

Or with specific scan mode:

```bash
./recon.sh -m nmap-only example.com example2.com
```

---

### 🔹 Interactive Mode

Let the tool prompt you for domain input dynamically:

```bash
./recon.sh -i -m all
```

Then follow the prompt and type domains one by one. Type `quit` to exit.

---

## 📁 Output Format

Each scan will generate:

```
<domain>_recon/
├── nmap            # Nmap scan results
├── dirsearch       # Dirsearch results
├── crt             # crt.sh JSON output
└── report          # Combined master report
```

Sample output from `report`:

```
This scan was created on Wed Jul 10 23:52:10 IST 2025
Results for Nmap:
80/tcp  open   http
443/tcp open   https

Results for Dirsearch:
/index.html [200 OK]
/admin/ [403 Forbidden]

Results for crt.sh:
example.com
sub.example.com
```

---

## 🛠️ Modify the Dirsearch Path (Optional)

If you want to run `dirsearch.py` from anywhere, add it to your PATH:

```bash
export PATH="$PWD/dirsearch:$PATH"
```

To make this permanent, add the above line to `~/.bashrc` or `~/.bash_profile`.

---

## 📸 Screenshots (Replace below with your own)

### ✔️ Example Run

```
$ ./recon.sh -m all scanme.nmap.org

This scan was created on Wed Jul 10 23:52:10 IST 2025
Creating directory scanme.nmap.org_recon.
Running Nmap scan...
Running Dirsearch scan...
Running crt.sh scan...
Generating report...
```
<img width="796" height="418" alt="Screenshot 2025-07-10 232911" src="https://github.com/user-attachments/assets/440d2df2-3507-443d-94b8-b4cc6c368daf" />
<img width="803" height="414" alt="Screenshot 2025-07-10 233206" src="https://github.com/user-attachments/assets/07f4926d-bbad-4ce8-b594-d542e7824e1b" />

---

## 🧠 Advanced Features

* ✅ Supports multiple domain scanning
* ✅ Interactive mode with live input
* ✅ Modular functions using `scan.lib`
* ✅ Report generation using `jq` and `grep`
* ✅ Uses regex filtering to clean Nmap output
* ✅ Compatible with `crt.sh` JSON API

---

## 🔐 Disclaimer

This tool is intended for educational and legal penetration testing use only. Do **not** scan systems or domains without explicit permission.

---

## 🙌 Credits

* Developed by Tanishq Ingole

---

## 📜 License

MIT License

```

---

Let me know your GitHub repo link or username if you'd like me to personalize the clone URL or add other sections like badges (build status, license, etc).
```
