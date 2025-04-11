======================================
    Fishing Script Installation Guide
======================================

=====================================
    https://discord.gg/ec7rmMHPTG
=====================================

To integrate the **Fishing Script** with your server, follow the steps below. You will need to have **`ox_inventory`** and **`oxlib`** already installed. If you haven't done so yet, please follow the installation steps for both libraries.

---

**Required Libraries:**

1. **ox_lib** - Download from GitHub:  
   https://github.com/overextended/ox_lib/releases/tag/v3.30.6

2. **ox_inventory** - Download from GitHub:  
   https://github.com/overextended/ox_inventory/releases/tag/v2.44.1

Make sure both **`ox_inventory`** and **`oxlib`** are installed and properly configured on your server.

---

**Step 1: Install Required Libraries**

Ensure both **`ox_inventory`** and **`oxlib`** are installed and configured on your server.

- Follow the official documentation for each library for installation and configuration.
- These libraries are essential for the proper functioning of the Fishing Script.

---

**Step 2: Upload Fishing Script Files**

1. **Download the Fishing Script**: Obtain the necessary files for the Fishing Script.

2. **Upload Image Files**:  
   - Navigate to the **`ox_inventory/web/images`** directory on your server.
   - Upload all the image files from the Fishing Script package to this directory.

---

**Step 3: Configure `items.lua`**

To configure the Fishing Script with your server, do the following:

1. **Navigate to the `items.lua` File**:  
   Go to **`ox_inventory/data/items.lua`** on your server.

2. **Add the Configuration**:  
   - Scroll to the bottom of the `items.lua` file.
   - Paste the pre-made configuration that comes with the Fishing Script (provided in the package).

This will register the fishing items in the inventory and ensure proper integration with your system.

---

**Step 4: Update `server.cfg`**

1. **Edit `server.cfg`**:  
   Open the **`server.cfg`** file in the root directory of your server.

2. **Add the Fishing Script to `server.cfg`**:  
   Add the following line to the file to ensure the Fishing Script is loaded when your server starts:

