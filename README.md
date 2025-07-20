## Password Manager

This application is open source feel free to create pull requests, to rate the code, report bugs or suggest new features.

We do not collect any account data or saved passwords. We only collect error messages for application maintenance.

Never share your password with anyone.

All data transmitted is encrypted, this project uses firebase to search and save your passwords.
  
Remember to regularly change your passwords, both the application login and your saved passwords, to maintain your security even better.

External packages used

  * auto_injector
  * cloud_firestore
  * firebase_auth
  * firebase_core
  * google_sign_in
  * localization
  * shared_preferences
  * url_launcher
  * provider
  * shimmer
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
   
  * Theme Mode
      * System mode
      * Dark mode
      * Light mode

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
<img width="200" src="https://github.com/user-attachments/assets/16ab09aa-83fb-484a-8232-07b765b666bb" />
<img width="200" src="https://github.com/user-attachments/assets/177b19d9-28ae-49b2-ac61-16502d193689" />
<img width="200" src="https://github.com/user-attachments/assets/2024e759-de49-4bb6-a5df-f17ea61a2591" />
<img width="200" src="https://github.com/user-attachments/assets/7051d9a7-ebdc-46fe-bc0e-fb1362246477" />

