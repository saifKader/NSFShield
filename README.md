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

The issue of NSF checks has gained significant prominence due to its impact on both individuals and businesses. Writing a check without sufficient funds can result in financial complexities and inconvenience for all parties involved. NSFShield directly addresses this challenge by introducing a groundbreaking process that guarantees the availability of funds for check transactions.

NSFShield's innovative approach revolves around a two-step process. First, users scan the check using document scanner, ensuring accurate and efficient scanning. Once the check details are verified, users have the option to instantly block and secure the specified amount in their bank accounts. This pioneering method ensures that the required funds are reserved, eliminating the risk of writing checks without adequate backing.

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