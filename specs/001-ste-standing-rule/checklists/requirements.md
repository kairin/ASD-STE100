# Specification Quality Checklist: ASD-STE100 standing writing rule

**Purpose**: Validate specification completeness and quality before proceeding to planning
**Created**: 2026-08-18
**Updated**: 2026-08-18 (revision 2)
**Feature**: [spec.md](../spec.md)

## Content Quality

- [x] No implementation details (languages, frameworks, APIs)
- [x] Focused on user value and business needs
- [x] Written for non-technical stakeholders
- [x] All mandatory sections completed

## Requirement Completeness

- [x] No [NEEDS CLARIFICATION] markers remain
- [x] Requirements are testable and unambiguous
- [x] Success criteria are measurable
- [x] Success criteria are technology-agnostic (no implementation details)
- [x] All acceptance scenarios are defined
- [x] Edge cases are identified
- [x] Scope is clearly bounded
- [x] Dependencies and assumptions identified

## Feature Readiness

- [x] All functional requirements have clear acceptance criteria
- [x] User scenarios cover primary flows
- [x] Feature meets measurable outcomes defined in Success Criteria
- [x] No implementation details leak into specification

## Notes

- Items marked incomplete require spec updates before `/speckit-clarify` or `/speckit-plan`

### Revision 2 record

The owner rejected the premise of revision 1. He asked why the gateway wrapper
could not carry the routing and the rule together. It can. Revision 1 had stated
a risk preference as a hard constraint, which is a specification defect: it
removed an option the owner wanted without evidence that the option was unsafe.

Changed:

- **FR-012** replaced. Was "the gateway wrapper MUST NOT be edited". Now "only
  the final command line may change, and every routing variable MUST survive".
- **SC-003** replaced. Was "stays byte-identical to its tracked copy". Now
  "live and tracked copies match, the script passes a syntax check, and both
  address exports survive".
- **FR-002 added** — the zero-argument requirement, in the owner's own words. It
  was implied before and never stated, so nothing tested it.
- **FR-003 and FR-004 added** — the two routes, and what each one covers.
- **FR-007, FR-008, FR-009 added** — check mode, the rename kill switch, and the
  step-aside behaviour when a caller supplies a competing argument.
- **SC-005 and SC-006 added** — the argument count a user must type, and the
  check mode reporting both states.
- User Story 1 rewritten around typing no argument. User Story 3 added for the
  check mode. Numbering of the content stories moved down.

### Validation record

Revision 2 passed on iteration 2. Iteration 1 found two failures:

1. **FR-002 was not testable as first written.** "The owner should not need to
   remember flags" states a feeling. Corrected to name the two commands and the
   argument count, which SC-005 then measures.
2. **An implementation detail leaked into FR-012.** The draft named the flag and
   the script path. Corrected to "the final command line of the gateway
   wrapper", which the plan resolves to a path.

### Known constraint on this spec

This feature is machine configuration, so several criteria name observable
machine state: restart count, syntax validity, guard-hook count, argument count.
These are outcomes a reader can check, not implementation instructions. No
criterion names a language, framework, or vendor product.
