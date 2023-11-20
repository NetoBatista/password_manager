## Password manager

This application is open source feel free to create pull requests, to rate the code, report bugs or suggest new features.

We do not collect any account data or saved passwords. We only collect error messages for application maintenance.

Never share your password with anyone.

All data transmitted is encrypted, this project uses firebase to search and save your passwords.
  
Remember to regularly change your passwords, both the application login and your saved passwords, to maintain your security even better.

Resources used

  * google_sign_in    
  * localization    
  * shared_preferences    
  * url_launcher    
  * firebase_auth
  * firebase_core    
  * firebase_messaging    
  * cloud_firestore    
  * flutter_launcher_icons

Features

  * Login    
      * Create account        
      * Anonymous login        
      * Google login        
      * Update password (with login email and password)        
      * Remove account
      
  * Password
      * Create
      * Get
      * Delete
      * Remove
        
  * Remove all data
      * Login
      * Passwords

## Let's talk about security

Firestore is being used to save the data, and for this we are using the official Google package https://pub.dev/packages/cloud_firestore

All data is encrypted by default, to learn more read at: https://cloud.google.com/firestore/docs/server-side-encryption

Firestore security rules

<img src="https://github.com/NetoBatista/password_manager/assets/23426240/26d057e4-7d56-4804-a49f-0b8f268414e3" width="600" />

This means that all data is saved in the collection corresponding to your user and only the user authenticated with that id has access to the data.

This way, your data will be safe even if your ID is exposed as it is necessary to log in to obtain this data.

To try the app you can download it:
* [Google Play](https://play.google.com/store/apps/details?id=br.com.jbsn.password_manager)

## App images:

<img src="https://github.com/NetoBatista/password_manager/assets/23426240/8ce509f5-4056-4a30-84dc-0b9ee1594961" width="200" />

<img src="https://github.com/NetoBatista/password_manager/assets/23426240/6ee74640-3484-4630-89e5-75f8d67ab025" width="200" />

<img src="https://github.com/NetoBatista/password_manager/assets/23426240/31e7c4eb-9137-4144-97af-50e3e172ea30" width="200" />

<img src="https://github.com/NetoBatista/password_manager/assets/23426240/1a536067-286b-47e0-9c25-be854b023752" width="200" />


