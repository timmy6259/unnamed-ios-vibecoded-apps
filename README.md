# Beginner iOS To-Do App

This repository is a simple starter iOS app built with SwiftUI for learning and personal use.

## What this app does
- Add tasks
- Mark tasks complete
- Delete tasks
- Save tasks locally in app storage

## Tech stack
- SwiftUI
- iOS 16+
- GitHub Actions for CI
- XcodeGen for project generation

## Local setup
1. Install Xcode
2. Install XcodeGen:
   ```bash
   brew install xcodegen
   ```
3. Generate the Xcode project:
   ```bash
   xcodegen generate
   ```
4. Open `ToDoApp.xcodeproj` in Xcode
5. Run it on a simulator or your iPhone

## CI
This repo includes a GitHub Actions workflow that generates the Xcode project and builds the app for the iOS simulator.

## Device target
The app is configured for iOS 16.0+, which is compatible with your iPhone SE 2 running iOS 18.6.2.

## Project goal
This is a simple learning project for:
- SwiftUI basics
- App storage
- GitHub workflow setup
- iOS app development
