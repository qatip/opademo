# OPA Demo — Policy as Code and Bundle Distribution

A public demonstration repository for exploring **Open Policy Agent (OPA)**, the **Rego policy language**, and the development, packaging and distribution of policies using OPA Bundles.

This repository contains generic, illustrative examples intended for technical education, experimentation and instructor-led demonstrations.

## Overview

Open Policy Agent (OPA) is a general-purpose policy engine that enables applications and platforms to make policy decisions independently of the systems responsible for enforcing them.

This repository demonstrates the journey from individual Rego rules to a modularised policy implementation that can be packaged and distributed as an OPA Bundle.

The examples use a fictional payment authorisation scenario to illustrate structured policy decisions.

The policy evaluates information supplied by an integrating system and returns one of three outcomes:

- **APPROVE** — The request satisfies the applicable policy conditions.
- **REJECT** — A known policy violation prevents the request from proceeding.
- **REVIEW** — Further information or handling is required before a decision can be finalised.

These outcomes are illustrative and do not represent a production banking authorisation model.

## Learning Objectives

The repository is designed to help learners understand:

1. How Rego rules implement policy decisions.
2. How complex policies can be refactored into meaningful helper rules.
3. How policies can be organised across multiple Rego modules.
4. The distinction between policy source code and deployed policy.
5. How OPA Bundles package policy modules and supporting data.
6. How a running OPA instance can retrieve and activate a published bundle.
7. Why policy versioning, testing, approval and distribution matter.

## Repository Structure

The intended repository structure is:

```text
opademo/
├── README.md
├── LICENSE
├── src/
│   ├── decision.rego
│   ├── account_rules.rego
│   ├── payment_rules.rego
│   └── evidence_rules.rego
├── bundle/
│   └── payment-bundle.tar.gz
├── examples/
│   ├── input-approve.json
│   ├── input-reject.json
│   └── input-review.json
└── tests/
    └── decision_test.rego
```

The repository structure may evolve as additional demonstrations are introduced.

## Policy Modules

The demonstration policy is organised into several Rego modules.

| Module | Purpose |
|---|---|
| `decision.rego` | Produces the final structured policy decision |
| `account_rules.rego` | Contains account-related policy conditions |
| `payment_rules.rego` | Contains payment-related conditions and restrictions |
| `evidence_rules.rego` | Handles required evidence and missing information |

Together, these modules implement a single policy decision contract.

The modules can share a common Rego package, allowing their rules to be evaluated together even though they are stored in separate files.

## OPA Bundles

An OPA Bundle is a distribution package containing Rego policy modules and, optionally, supporting data and metadata.

The demonstration bundle is built from the modularised policy and published as a compressed archive.

OPA can be configured to retrieve the bundle over HTTP(S), load its contents and evaluate policy requests.

This illustrates an important distinction:

**Git manages the policy source. A bundle packages the policy. OPA retrieves and evaluates it.**

The bundle does not construct the input for an individual policy decision or enforce the returned result. Those responsibilities belong to the integrating and enforcing systems.

## Using the Demonstration

The repository is intended to support instructor-led demonstrations and independent exploration.

Typical activities include:

- Examining the individual Rego modules.
- Understanding how the modules contribute to the final decision.
- Comparing the modularised policy with a single-file implementation.
- Inspecting the contents of an OPA Bundle.
- Configuring OPA to retrieve the published bundle.
- Evaluating example requests and interpreting the results.

Detailed commands and configuration examples will be added alongside the published demonstration artefacts.

## Policy Development and Governance

In a managed environment, policy changes should follow an appropriate review, testing and approval process before being published.

A typical policy lifecycle is:

**Define → Author → Review → Test → Approve → Publish → Distribute → Consume**

Version control, automated testing and controlled publication can help ensure that running OPA instances receive the intended policy versions.

This demonstration introduces these concepts without prescribing a particular production governance model.

## Important Limitations

The examples are provided for educational purposes.

They use fictional identities, accounts, permissions and business rules.

They are not intended for direct deployment into production environments.

Real-world implementations require appropriate security controls, authoritative data sources, testing, operational monitoring, policy governance and enforcement integration.

## Copyright and Licence

Copyright © 2026 QA Ltd.

This repository is licensed under the **MIT License**. See [LICENSE](LICENSE) for the full licence terms.

The materials may be used, copied, modified and redistributed in accordance with the terms of the MIT License.

All examples are provided for educational and demonstration purposes only.

## Disclaimer

This project is provided **"AS IS"**, without warranty of any kind, as described in the MIT License.

The examples are illustrative and should not be relied upon as production-ready authorisation or security controls.

## References

- [Open Policy Agent](https://www.openpolicyagent.org/)
- [OPA Documentation](https://www.openpolicyagent.org/docs)
- [Rego Policy Language](https://www.openpolicyagent.org/docs/policy-language)
- [OPA Bundles](https://www.openpolicyagent.org/docs/management-bundles)
- [OPA GitHub Repository](https://github.com/open-policy-agent/opa)
