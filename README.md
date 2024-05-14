<!--

This source file is part of the OwnYourData based on the Stanford Spezi Template Application project

SPDX-FileCopyrightText: 2023 Stanford University

SPDX-License-Identifier: MIT

-->

# OwnYourData

This repository contains the OwnYourData app.
The OwnYourData is using the [Spezi](https://github.com/StanfordSpezi/Spezi) ecosystem and builds on top of the [Stanford Spezi Template Application](https://github.com/StanfordSpezi/SpeziTemplateApplication).

> [!NOTE]  
> Do you want to learn more about the Stanford Spezi Template Application and how to use, extend, and modify this application? Check out the [Stanford Spezi Template Application documentation](https://stanfordspezi.github.io/SpeziTemplateApplication)


## Update the Web API

Install the OpenAPI Generator as described at https://github.com/OpenAPITools/openapi-generator.

Please replace the `NCIClinicalTrialsSearchAPI.json` with the latest version of the OpenAPI spec.

After you have installed the Generator and updated the open API spec, you can regenerate the client stub using the following command:
```shell
$ openapi-generator generate -i NCIClinicalTrialsSearchAPI.json -g swift5 -o ./NCIClinicalTrialsSearchAPI --skip-validate-spec
```


## License

This project is licensed under the MIT License. See [Licenses](https://github.com/StanfordBDHG/ResearchKitOnFHIR/tree/main/LICENSES) for more information.


## Contributors

This project is developed as part of the Stanford University projects at Stanford.
See [CONTRIBUTORS.md](https://github.com/StanfordBDHG/ResearchKitOnFHIR/tree/main/CONTRIBUTORS.md) for a full list of all ResearchKitOnFHIR contributors.


## Notices

ResearchKit is a registered trademark of Apple, Inc.
FHIR is a registered trademark of Health Level Seven International.

![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-light.png#gh-light-mode-only)
![Stanford Byers Center for Biodesign Logo](https://raw.githubusercontent.com/StanfordBDHG/.github/main/assets/biodesign-footer-dark.png#gh-dark-mode-only)
