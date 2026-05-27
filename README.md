# 🔗 Batch Link Opener

![Batch Script](https://img.shields.io/badge/script-batch-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows-0078D4.svg)
![Links](https://img.shields.io/badge/batch-opens%20all%20links-orange.svg)

A simple Windows batch script that automatically finds a text file in the current directory and opens every URL from it in your default browser. Perfect for when you have a list of links to visit without clicking each one manually.

## ✨ Features

- 🔍 **Auto-detects** the first `.txt` file in the folder
- 🧹 **Smart URL cleaning** - removes weird characters (・ｿ, spaces, quotes)
- 🔗 **Auto-formats** URLs - adds `https://` to `www.` and `youtu` links
- ⏱️ **1-second delay** between opens to prevent browser overload
- 📊 **Progress tracking** - shows which link is being opened
- 🛡️ **Error handling** - skips invalid lines and empty URLs

## 🚀 Quick Start

1. Place `open_links.bat` in a folder with your text file

2. Create a text file (e.g., `paste links (one line at a time).txt`) with one URL per line:
