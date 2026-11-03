# MotorbikeServices - Claude Project Instructions

## 1. Project Context

This is a completed university project for the Windows Programming
course at HUTECH.

Project: MotorbikeServices
Technology: C#, .NET 10, Windows Forms, SQL Server, EF Core 9.
Architecture: Three-layer architecture (GUI, BLL, DAL).

The project is in the post-implementation review and learning phase.
Do not assume that the project needs additional feature development.

## 2. Mandatory Instructions

Read these files before starting:
- AGENTS.md
- docs/AI_HANDOVER.md
- docs/PROGRESS.md

Follow all rules in AGENTS.md.

If documentation conflicts with the current source code:
- Do not silently choose one version.
- Identify the conflict.
- Inspect relevant source files.
- Report the evidence and ask for clarification when necessary.

## 3. Primary Objectives

### Objective A: Academic and Technical Review
- Review the project as a university lecturer and senior software engineer.
- Evaluate architecture, code organization, database design, EF Core usage,
  business logic, UI implementation and maintainability.
- Identify strengths, weaknesses, risks and technical debt.
- Assess alignment with the Windows Programming course.

### Objective B: Project Knowledge Extraction
- Understand the entire system from GUI to BLL to DAL to SQL Server.
- Map all modules, features, entities, relationships and workflows.
- Explain how important classes, methods and components work.
- Cite actual file paths and relevant code locations as evidence.

### Objective C: Technical Education
- Teach the project progressively, from system overview to individual modules.
- Explain concepts, design decisions, data flows and implementation details.
- Use Mermaid diagrams where appropriate.
- Distinguish verified facts from assumptions and recommendations.

### Objective D: Presentation and Defense
- Prepare a presentation based on the actual implementation.
- Prioritize database design, SQL, business workflows and important technical decisions.
- Prepare potential lecturer questions and evidence-based answers.
- Keep explanations understandable to all team members.

## 4. Evidence and Accuracy

Classify findings as:
- VERIFIED: directly confirmed from source code or database artifacts.
- REPORTED: stated in existing project documentation.
- INFERRED: reasoned from implementation, but not directly confirmed.
- RECOMMENDED: proposed improvement, not an existing feature.

Never claim a feature works merely because a class or method exists.
Distinguish implementation evidence from runtime verification.

## 5. Read-only First

During the initial review:
- Do not modify source code, project files, database scripts or documentation.
- Do not run destructive commands or database updates.
- Do not commit, push, reset, checkout or clean Git changes.
- Do not delete or overwrite any files.
- Build and test only when explicitly approved.

First produce an inventory and analysis plan.
Wait for approval before making changes.

## 6. Communication

- Respond in Vietnamese by default.
- Preserve technical terms in English where appropriate.
- Explain technical concepts precisely and progressively.
- Avoid unsupported assumptions.
- Report important findings with file paths and evidence.
- Separate critical issues from optional improvements.
