<div id="top" align="center">

<!-- Shields Header -->
[![Contributors][contributors-shield]](https://github.com/franckferman/Hyper-V-Toolbox/graphs/contributors)
[![Forks][forks-shield]](https://github.com/franckferman/Hyper-V-Toolbox/network/members)
[![Stargazers][stars-shield]](https://github.com/franckferman/Hyper-V-Toolbox/stargazers)
[![Issues][issues-shield]](https://github.com/franckferman/Hyper-V-Toolbox/issues)
[![License][license-shield]](https://github.com/franckferman/Hyper-V-Toolbox/blob/stable/LICENSE)

<!-- Logo -->
<a href="https://github.com/franckferman/Hyper-V-Toolbox">
  <img src="https://raw.githubusercontent.com/franckferman/Hyper-V-Toolbox/refs/heads/stable/docs/github/graphical_resources/Logo-without_background-Hyper-V-Toolbox.png" alt="Hyper-V-Toolbox Logo" width="auto" height="auto">
</a>

<!-- Title & Tagline -->
<h3 align="center">🪷 Hyper-V-Toolbox</h3>
<p align="center">
    <em>Hyper-V Toolbox: Streamlining Virtual Machine Management.</em>
    <br>
     Providing users with a more efficient and user-friendly tool for virtual machine management — Inspired by Vagrant and Docker.
</p>

</div>

## 📜 Table of Contents

<details open>
  <summary><strong>Click to collapse/expand</strong></summary>
  <ol>
    <li><a href="#-about">📖 About</a></li>
    <li><a href="#-installation">🛠️ Installation</a></li>
    <li><a href="#-usage">🎮 Usage</a></li>
    <li><a href="#-contributing">🤝 Contributing</a></li>
    <li><a href="#-star-evolution">🌠 Star Evolution</a></li>
    <li><a href="#-license">📜 License</a></li>
    <li><a href="#-contact">📞 Contact</a></li>
  </ol>
</details>

## 📖 About

Hyper-V_Toolbox is a modern PowerShell-based solution that streamlines the management of virtual machines.

Designed for both beginners and advanced users, it offers a semi-graphical interface that simplifies complex Hyper-V tasks, making it an ideal tool for cybersecurity labs, development environments, and network administration.

Whether you're a student, a developer, or an IT professional, Hyper-V_Toolbox provides an efficient and accessible way to deploy and manage virtualized environments with ease.

### 🌟 Key Features

- ✅ Semi-Graphical PowerShell Interface — intuitive, interactive, and powerful.
- ✅ Automated Hyper-V Image Management — manage, clone, and deploy pre-configured VM environments effortlessly.
- ✅ Streamlined Operations — optimized for educational and professional contexts to boost productivity and simplify workflows.
- ✅ Support for Multiple Images and JSON Configurations — flexible management of complex lab setups.

### ⚠️ Disclaimer & Development Notice

🚨 Important note regarding the origins of this project:
I previously worked on a similar internal tool as part of a professional project.
However, in strict respect of confidentiality agreements and professional ethics, none of the original code has been reused or shared in this repository.
The entire development of Hyper-V_Toolbox presented here is independent and 100% recreated from scratch for personal and community purposes.

> 🛡️ I fully respect the contractual obligations of my past work and do not retain or reuse any proprietary code.

💡 Current Status:
This community version of Hyper-V_Toolbox is still in development and far from being finalized.
Although functional in its current form, many features are still under construction, and improvements are ongoing.

> 🗃️ Note about the /archive folder:
> You will find raw, unorganized, and experimental code snippets in the /archive directory. These are early drafts, deprecated, or experimental pieces I may reuse or clean up later.
> Please do not consider these files as stable or production-ready.

<p align="right">(<a href="#top">🔼 Back to top</a>)</p>

## 🚀 Installation

### Prerequisites

- **Windows OS** (Tested on **Windows 10 & 11** — may work on older versions but not officially supported).
- **PowerShell 5.1 or higher** (pre-installed on modern Windows).
- **Hyper-V** Feature enabled (mandatory for VM management).

> ⚠️ **Note**: Entirely written in **pure PowerShell**, **no external software required**.

### Getting Hyper-V-Toolbox

#### Option 1: One-liner with `Invoke-WebRequest`
```powershell
Invoke-WebRequest https://raw.githubusercontent.com/franckferman/Hyper-V-Toolbox/stable/HyperV-Toolbox.ps1 -OutFile HyperV-Toolbox.ps1
```

#### Option 2: Clone via Git
```powershell
git clone https://github.com/franckferman/Hyper-V-Toolbox.git
```

#### Option 3: **Direct Download** from GitHub
1. Go to GitHub repo.
2. Click `<> Code` → `Download ZIP`.
3. Extract the archive to your desired location.

<p align="right">(<a href="#top">🔼 Back to top</a>)</p>

## 🎮 Usage

### Getting started

1. Temporarily allow script execution:
```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process
```

> 🛑 Important: This command temporarily adjusts the execution policy to allow script execution for the current process only, minimizing security risks. 
> Always examine scripts before executing them to ensure safety.

2. Run the script:
```powershell
.\HyperV-Toolbox.ps1
```

Alternatively, for a streamlined approach, combine the execution policy adjustment with script launch in a single line:
```powershell
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope Process; .\HyperV-Toolbox.ps1
```

> This command executes the script. 
> The script provides a user-friendly graphical interface, facilitating navigation through various tasks and options with ease.

<p align="right">(<a href="#top">🔼 Back to top</a>)</p>

## 🤝 Contributing

We truly appreciate and welcome community involvement. Your contributions, feedback, and suggestions play a crucial role in improving the project for everyone. If you're interested in contributing or have ideas for enhancements, please feel free to open an issue or submit a pull request on our GitHub repository. Every contribution, no matter how big or small, is highly valued and greatly appreciated!

<p align="right">(<a href="#top">🔼 Back to top</a>)</p>

## 🌠 Star Evolution

Explore the star history of this project and see how it has evolved over time:

<a href="https://star-history.com/#franckferman/Hyper-V-Toolbox&Timeline">
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=franckferman/Hyper-V-Toolbox&type=Timeline&theme=dark" />
    <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=franckferman/Hyper-V-Toolbox&type=Timeline" />
  </picture>
</a>

Your support is greatly appreciated. We're grateful for every star! Your backing fuels our passion. ✨

## 📚 License

This project is licensed under the GNU Affero General Public License, Version 3.0. For more details, please refer to the LICENSE file in the repository: [Read the license on GitHub](https://github.com/franckferman/Hyper-V-Toolbox/blob/stable/LICENSE)

<p align="right">(<a href="#top">🔼 Back to top</a>)</p>

## 📞 Contact

[![ProtonMail][protonmail-shield]](mailto:contact@franckferman.fr)
[![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/franckferman)
[![Twitter][twitter-shield]](https://www.twitter.com/franckferman)

<p align="right">(<a href="#top">🔼 Back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/franckferman/Hyper-V-Toolbox.svg?style=for-the-badge
[contributors-url]: https://github.com/franckferman/Hyper-V-Toolbox/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/franckferman/Hyper-V-Toolbox.svg?style=for-the-badge
[forks-url]: https://github.com/franckferman/Hyper-V-Toolbox/network/members
[stars-shield]: https://img.shields.io/github/stars/franckferman/Hyper-V-Toolbox.svg?style=for-the-badge
[stars-url]: https://github.com/franckferman/Hyper-V-Toolbox/stargazers
[issues-shield]: https://img.shields.io/github/issues/franckferman/Hyper-V-Toolbox.svg?style=for-the-badge
[issues-url]: https://github.com/franckferman/Hyper-V-Toolbox/issues
[license-shield]: https://img.shields.io/github/license/franckferman/Hyper-V-Toolbox.svg?style=for-the-badge
[license-url]: https://github.com/franckferman/Hyper-V-Toolbox/blob/stable/LICENSE
[protonmail-shield]: https://img.shields.io/badge/ProtonMail-8B89CC?style=for-the-badge&logo=protonmail&logoColor=blueviolet
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=blue
[twitter-shield]: https://img.shields.io/badge/-Twitter-black.svg?style=for-the-badge&logo=twitter&colorB=blue

