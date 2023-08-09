<!--

This source file is part of the Stanford OwnYourData Application project

SPDX-FileCopyrightText: 2023 Stanford University

SPDX-License-Identifier: MIT

-->

# Stanford OwnYourData Applicationn

[![Beta Deployment](https://github.com/StanfordBDHG/OwnYourData/actions/workflows/beta-deployment.yml/badge.svg)](https://github.com/StanfordBDHG/OwnYourData/actions/workflows/beta-deployment.yml)
[![codecov](https://codecov.io/gh/StanfordBDHG/OwnYourData/branch/main/graph/badge.svg?token=9fvSAiFJUY)](https://codecov.io/gh/StanfordBDHG/OwnYourData)
[![DOI](https://zenodo.org/badge/589846478.svg)](https://zenodo.org/badge/latestdoi/589846478)

This repository contains the Stanford OwnYourData Applicationn.
It demonstrates using the [Spezi](https://github.com/StanfordBDHG/Spezi) framework template and builds on top of the [StanfordBDHG Template Application](https://github.com/StanfordBDHG/TemplateApplication).


## Application Structure

The Stanford OwnYourData Applicationn uses a modularized structure enabled by using the Swift Package Manager.

The application contains the following five modules that are separated into different Swift Package Manger Targets in the `TemplateApplicationModules` Swift Package.

The application uses the Spezi `FHIR` standard to provide a shared repository for data exchanged between different modules using the `FHIR` standard.
You can learn more about the Spezi standards-based software architecture in the [Spezi documentation](https://github.com/StanfordBDHG/Spezi).


## Build and Run the Application

You can build and run the application using [Xcode](https://developer.apple.com/xcode/) by opening up the **TemplateApplication.xcodeproj**.

The application provides a [Firebase Firestore](https://firebase.google.com/docs/firestore)-based data upload and [Firebase Authentication](https://firebase.google.com/docs/auth) login & sign-up.
It is required to have the [Firebase Emulator Suite](https://firebase.google.com/docs/emulator-suite) to be up and running to use these features to build and test the application locally. Please follow the [installation instructions](https://firebase.google.com/docs/emulator-suite/install_and_configure). 

You do not have to make any modifications to the Firebase configuration, login into the `firebase` CLI using your Google account, or create a project in firebase to run, build, and test the application!

Startup the [Firebase Emulator Suite](https://firebase.google.com/docs/emulator-suite) using
```
$ firebase emulators:start
```

After the emulators have started up, you can run the application in your simulator to build, test, and run the application.

The application includes the following feature flags that can be configured in the [scheme editor in Xcode](https://help.apple.com/xcode/mac/11.4/index.html?localePath=en.lproj#/dev0bee46f46) and selecting the **TemplateApplication** scheme, the **Run** configuration, and to switch to the **Arguments** tab to add, enable, disable, or remove the following arguments passed on launch:
- ``--skipOnboarding``: Skips the onboarding flow to enable easier development of features in the application and to allow UI tests to skip the onboarding flow.
- ``--showOnboarding``: Always show the onboarding when the application is launched. Makes it easy to modify and test the onboarding flow without the need to manually remove the application or reset the simulator.
- ``--disableFirebase``: Disables the Firebase interactions, including the login/sign-up step and the Firebase Firestore upload.
- ``--useFirebaseEmulator``: Defines if the application should connect to the local firebase emulator. Always set to true when using the iOS simulator.


### Template Onboarding Flow

The `TemplateOnboardingFlow` module contains the different steps displayed in the onboarding flow.
It uses the Spezi `Onboarding` module to display different onboarding-related views like the information about the application, a consent screen, and a screen to display a HealthKit consent view.

<p float="left">
 <img width="250" alt="A screen displaying welcome information." src="Figures/TemplateOnboardingFlow/Welcome.png">
 <img width="250" alt="A screen showing an overview of the modules used in the Stanford OwnYourData Applicationn." src="Figures/TemplateOnboardingFlow/InterestingModules.png">
 <img width="250" alt="A screen displaying the consent view." src="Figures/TemplateOnboardingFlow/Consent.png">
 <img width="250" alt="A screen showing a view displaying the HealthKit access screen." src="Figures/TemplateOnboardingFlow/HealthKitAccess.png">
</p>


### Template Schedule

The `TemplateSchedule` module provides the functionality to schedule a recurring task and bind it to an action, e.g., displaying a questionnaire.
It uses the Spezi `Scheduler` and `Questionnaires` modules to schedule the tasks as defined in the `TemplateApplicationScheduler`.

<p float="left">
 <img width="250" alt="A screen displaying the Scheduler UI." src="Figures/TemplateSchedule/Scheduler.png">
 <img width="250" alt="A screen showing a questionnaire using ResearchKit." src="Figures/TemplateSchedule/Questionnaire.png">
 <img width="250" alt="A screen displaying the Scheduler UI when the questionnaire is finished." src="Figures/TemplateSchedule/QuestionnaireFinished.png">
</p>


### Template Contacts

The `TemplateContacts` module provides the functionality to display contact information in your application.
It uses the Spezi `Contacts` module to use the contact-related views provided by Spezi.

<p float="left">
 <img width="250" alt="A screen displaying the Contact UI." src="Figures/TemplateContacts/Contacts.png">
</p>


### Template Mock Data Storage Provider

The `TemplateMockDataStorageProvider` module allows a developer to get an overview of the synconization of data between the local `FHIR` model and a cloud storage provider.
It uses the Spezi `DataStorageProvider`s to get information that is stored in the `FHIR` standard in the Stanford OwnYourData Applicationn.

<p float="left">
 <img width="250" alt="A screen displaying the list of Mock Data Storage Provider uploads." src="Figures/TemplateMockDataStorageProvider/TemplateMockDataStorageProviderList.png">
 <img width="250" alt="A screen displaying the detailed overview of one Mock Data Storage Provider upload." src="Figures/TemplateMockDataStorageProvider/TemplateMockDataStorageProviderDetail.png">
</p>


## Continous Delivery Workflows

The Stanford OwnYourData Applicationn includes continuous integration (CI) and continuous delivery (CD) setup.
- Automatically build and test the application on every pull request before deploying it.
- An automated setup to deploy the application to TestFlight every time there is a new commit on the repository's main branch.
- Ensure a coherent code style by checking the conformance to the SwiftLint rules defined in `.swiftlint.yml` on every pull request and commit.
- Ensure conformance to the [REUSE Spacification]() to property license the application and all related code.

Please refer to the [StanfordBDHG Template Application](https://github.com/StanfordBDHG/TemplateApplication) and the [ContinousDelivery Example by Paul Schmiedmayer](https://github.com/PSchmiedmayer/ContinousDelivery) for more background about the CI and CD setup for the Stanford OwnYourData Applicationn.


## Contributors & License

This project is based on [ContinousDelivery Example by Paul Schmiedmayer](https://github.com/PSchmiedmayer/ContinousDelivery), and the [StanfordBDHG Template Application](https://github.com/StanfordBDHG/TemplateApplication) provided using the MIT license.
You can find a list of contributors in the `CONTRIBUTORS.md` file.

The Stanford OwnYourData Applicationn and the Spezi framework are licensed under the MIT license.
