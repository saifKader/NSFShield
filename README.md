<h1 align="center"> NSFShield </h1> <br>

<p align="center">
  <img src="https://github.com/saifKader/NSFShield/blob/main/assets/images/logo.png" alt="NSFShield Banner" width="300">
</p>

In an era where NSF (Non-Sufficient Funds) checks have become a prevalent challenge, NSFShield emerges as a transformative solution. Built on precision and security, this Flutter mobile application redefines how individuals manage, verify, and secure their financial activities.


## Table of Contents

- [Introduction](#introduction)
- [App Structure](#app-structure)
- [Technologies and Tools Used](#technologies-and-tools-used)
- [Features](#features)

## Introduction

The challenge of NSF (Non-Sufficient Funds) checks has become a concern for individuals and businesses in the financial landscape. Issuing a check without enough funds can lead to complex financial problems and inconvenience. NSFShield addresses this issue with an innovative solution that transforms the way we handle check transactions.

NSFShield's solution is based on a two-step process. First, users employ the document scanner, a smart tool that efficiently captures check details, including the CMC 7 characters. These characters contain crucial information such as the account holder's details. Following this, a meticulous check verification takes place. Users can swiftly and securely block a specific amount in their bank accounts, but only if sufficient funds are available. This ensures that the necessary funds are reserved, minimizing the risk of writing checks without proper financial backing.
## App Structure

NSFShield's architecture is thoughtfully designed to support its mission of efficient check management. The app follows the MVVM pattern, guided by Clean Architecture principles. This ensures a clear separation of concerns and facilitates smooth codebase management. BLoC state management enhances the app's reactivity and responsiveness.

## Technologies and Tools Used

- [Flutter](https://docs.flutter.dev)
- [Dio](https://pub.dev/packages/dio)
- [Flask](https://flask.palletsprojects.com/en/2.1.x/)
- [Document Scanner](https://pub.dev/packages/document_scanner_flutter)
- [CMC-7 OCR Model](https://github.com/saifKader/CMC-7-trained-model)
- [PostgreSQL](https://www.postgresqltutorial.com)

## Features

- **Authentication and User Profiles**: Access your account securely.

- **Dashboard Overview**: Quickly grasp recent check transactions, account balance, and blocked funds.

- **Effortless Check Scanning**: Utilize the document_scanner_flutter package for precise check scans. Our proprietary OCR model rapidly detects CMC 7 codes.

- **Precise Check Verification**: Specify the desired blocked amount, NSFShield meticulously verifies fund availability and secures it with an SMS pin verification exclusively for the account holder.

- **Robust Transaction Security**: Implement advanced security measures for transaction safety.

- **Optimized Data Handling**: Utilize optimized data storage via hydrated storage for enhanced efficiency.

- **Custom OCR Model**: Explore our [custom OCR model](https://github.com/saifKader/CMC-7-trained-model) tailored for CMC 7 character recognition.
<p align="center">
  <img src="https://imgur.com/NlwxU3g.png" width=200>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="https://imgur.com/vLTAAla.png" width=200>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="https://imgur.com/2v4ClQI.png" width=200>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;

</p>
<p align="center">
  <img src="https://imgur.com/aNtufFI.png" width=200>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
    <img src="https://imgur.com/6SOthAJ.png" width=200>
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;


</p>
