# GitHub Repository Setup & Vercel Deployment Guide

## Step 1: Create GitHub Repository

1. Go to: https://github.com/new (you already have this tab open!)
2. Log in to your GitHub account if needed
3. Repository name: `Library-Management-System`
4. Description: "Modern library management system with premium dark theme UI"
5. Set to **Public**
6. **DO NOT** check:
   - ❌ Add a README file
   - ❌ Add .gitignore
   - ❌ Choose a license
   (We already have these files locally)
7. Click "Create repository"

## Step 2: Push Code to GitHub

After creating the repository, GitHub will show you commands. Use these commands in your terminal:

```bash
# Navigate to your project (if not already there)
cd "c:\Users\swast\OneDrive\Desktop\Libray Management System"

# Add the remote repository (replace YOUR_USERNAME with your GitHub username)
git remote add origin https://github.com/YOUR_USERNAME/Library-Management-System.git

# Rename branch to main (if needed)
git branch -M main

# Push code to GitHub
git push -u origin main
```

## Step 3: Deploy to Vercel

### Option A: Using Vercel CLI (Recommended)
```bash
# Install Vercel CLI globally
npm install -g vercel

# Login to Vercel
vercel login

# Deploy
vercel
```

### Option B: Using Vercel Website
1. Go to: https://vercel.com/new
2. Click "Import Git Repository"
3. Select your GitHub account and the `Library-Management-System` repository
4. Click "Import"
5. Configure:
   - Framework Preset: Other
   - Root Directory: ./
   - Build Command: (leave empty)
   - Output Directory: (leave empty)
6. Click "Deploy"

## Step 4: Get Your Live URL

After deployment, Vercel will provide you with a URL like:
`https://library-management-system-xxx.vercel.app`

---

## Quick Reference Commands

```bash
# Check Git status
git status

# View remote URL
git remote -v

# Check Vercel deployment status
vercel ls
```

## Need Help?

If you encounter any issues:
1. Make sure you're logged into GitHub
2. Ensure your GitHub username is correct in the remote URL
3. Check that you have push permissions to the repository
