- memory always create a todo list when working on complex tasks to track progress and remain on track
- when I say commit to github, that means to commit the code to the respective github.com repo, I dont want to only save it locally but also push the changes to the remote repository.
- CLI-FIRST AUTOMATION PHILOSOPHY:
  * CRITICAL: ALWAYS use service provider CLIs as the PRIMARY method for executing tasks
  * NEVER ask the user to perform tasks through web UIs if a CLI exists
  * This dramatically improves development velocity and automation
  * Available CLIs to use: gcloud (Google Cloud Run), supabase (Supabase), stripe (Stripe), gh (GitHub), aws (AWS), npm/npx, git, docker, etc.
  * Examples: deploy via 'gcloud run deploy', manage DB via 'supabase', create webhooks via 'stripe', open PRs via 'gh pr create'
  * If a CLI isn't installed, install it proactively using npm/brew/curl and configure with credentials from ~/.credentials.env
  * Execute tasks programmatically instead of asking user to use UI - this is your DEFAULT approach to save time
  * Only fallback to manual UI tasks if absolutely no CLI/API option exists
- where possible, always validate your proposals per official documentation. dont propose option unless you've fully vetted that its possible first.
- CONTEXT7 - UP-TO-DATE DOCUMENTATION:
  * ALWAYS use Context7 MCP to fetch current documentation when working with libraries/frameworks
  * Before implementing code using external libraries, call Context7 to get version-specific docs
  * This prevents hallucinated APIs and outdated patterns from training data
  * Key libraries to ALWAYS check: Next.js, React, Supabase, Stripe, Google Cloud Run, Tailwind, shadcn/ui, Clerk, etc.
  * Usage: Use `resolve-library-id` to find the library, then `get-library-docs` for current docs
  * CRITICAL: Never assume API signatures - verify with Context7 first
- stop creating .md files for simple plans, explain them to me for my approval within claude code itself.
- if you find a bug during your testing,proactively fix it using the bmad dev agent and validate the fix with the bmad qa agent.
- where you can setup authentication, keys, configurations using the given service provider's command line, do it and don't wait for me. be proactive.
- when I ask a question, stop creating .md files, just explain it to me in the terminal.
- CREDENTIALS STORAGE:
  * CRITICAL: All API keys, tokens, and credentials are centrally stored in ~/.credentials.env (chmod 600, 740+ lines, 80+ credentials)
  * Source of truth: iCloud Drive (~/.credentials.env synced from iCloud)
  * ALWAYS check ~/.credentials.env FIRST before asking the user for any credentials
  * File contains: Google Cloud (Cloud Run, Gemini, Imagen, Maps, Calendar), AWS (Access Keys, Route 53), Supabase (2 projects with all keys), Clerk (auth), Stripe (live + test), Plaid (banking), QuickBooks (accounting), Amadeus (travel), Resend (email), Microsoft Clarity (analytics), Zapier (webhooks), JWT secrets, SSH keys, Git config, and more
  * NOTE: Vercel credentials have been REMOVED (all deployments use Google Cloud Run)
  * When you discover NEW credentials in project .env files, ADD them to ~/.credentials.env immediately
  * NEVER commit ~/.credentials.env to git (protected by global .gitignore)
  * Keep project-specific .env files local and never commit them
  * File location: /Users/sameerrijhsinghani/.credentials.env (synced to iCloud)
- BMAD METHOD v6 - AUTOMATIC WORKFLOW SELECTION:
  * CRITICAL: Claude MUST automatically detect the type of work and invoke the appropriate BMAD workflow
  * DO NOT ask the user which workflow to use - analyze the request and select automatically

  ## DETECTION RULES (apply in order):

  ### NEW PROJECT / NEW APP BUILD:
  When user says: "build", "create app", "new project", "start fresh", "greenfield"
  → AUTO-INVOKE: /bmad:bmm:workflows:workflow-init to analyze and recommend track
  → Then follow: /bmad:core:workflows:brainstorming → /bmad:bmm:workflows:create-prd → /bmad:bmm:workflows:create-architecture → /bmad:bmm:workflows:sprint-planning → implement

  ### NEW FEATURE / NEW CAPABILITY:
  When user says: "add feature", "new capability", "implement [something new]", "I want to add"
  → AUTO-INVOKE: /bmad:bmm:agents:architect for design validation FIRST
  → Then: /bmad:bmm:workflows:create-prd (if no PRD exists) → /bmad:bmm:workflows:sprint-planning → implement

  ### ENHANCEMENT / MODIFICATION TO EXISTING:
  When user says: "update", "modify", "change", "improve", "enhance", "refactor"
  → Check if story file exists in _bmad-output/implementation-artifacts/
  → If yes: /bmad:bmm:workflows:dev-story @story_file
  → If no: /bmad:bmm:workflows:create-story first, then develop

  ### BUG FIX:
  When user says: "fix", "bug", "broken", "not working", "error"
  → /bmad:bmm:agents:dev to investigate and fix
  → /bmad:bmm:workflows:code-review to validate fix

  ### IDEATION / BRAINSTORMING:
  When user says: "idea", "brainstorm", "think about", "what if", "explore options"
  → AUTO-INVOKE: /bmad:core:workflows:brainstorming

  ## IMPLEMENTATION WORKFLOW (after planning is done):
  Step 1) /bmad:bmm:workflows:dev-story @tag_story_file
  Step 2) /bmad:bmm:workflows:code-review @tag_story_file - If review passes → skip to step 5
  Step 3) /bmad:bmm:agents:dev to fix issues from review
  Step 4) /bmad:bmm:workflows:code-review again
  Step 5) Create PR
  Step 6) Merge PR into main

  ## KEY BMAD v6 COMMANDS:
  ### Agents:
  * `/bmad:bmm:agents:architect` - System design, technical decisions
  * `/bmad:bmm:agents:analyst` - Requirements gathering, business analysis
  * `/bmad:bmm:agents:dev` - Implementation
  * `/bmad:bmm:agents:pm` - Project management
  * `/bmad:bmm:agents:sm` - Scrum master
  * `/bmad:bmm:agents:ux-designer` - UX design
  * `/bmad:bmm:agents:tea` - Test architect
  * `/bmad:core:agents:bmad-master` - Complex coordination across agents

  ### Workflows:
  * `/bmad:bmm:workflows:workflow-init` - Analyzes project, recommends workflow track
  * `/bmad:bmm:workflows:create-prd` - Product Requirements Document
  * `/bmad:bmm:workflows:create-architecture` - Technical architecture design
  * `/bmad:bmm:workflows:sprint-planning` - Break work into implementable stories
  * `/bmad:bmm:workflows:dev-story` - Develop a story
  * `/bmad:bmm:workflows:create-story` - Create a new story
  * `/bmad:bmm:workflows:code-review` - Review code
  * `/bmad:bmm:workflows:research` - Research a topic
  * `/bmad:core:workflows:brainstorming` - Ideation and design thinking

  ## OUTPUT FOLDERS (v6 convention):
  * `_bmad-output/planning-artifacts/` - PRDs, architecture docs, brainstorming
  * `_bmad-output/implementation-artifacts/` - Sprint stories, task breakdowns
  * `docs/` - Long-term documentation only
- always always always defer to using the service provider's CLI, don't ask me to do anything via a UI if you can help it.
- RAJ PHOTO VIDEO DATA MODEL:
  * leads table (1,135 rows) = ALL inquiries (booked + non-booked). This is the master table for analytics.
  * bookings table (580 rows) = Only confirmed bookings. Links to leads via leads.booking_id
  * leads.legacy_client_id maps to CSV "Client ID" column
  * leads.legacy_booked_flag stores Y/N/Conflict/Canceled/Refused/Postponed
  * TIER LOGIC for photo/video packages from CSV binary columns:
    - Photo Luxe: Wedding + (Photo Wedding Day 12hr=1 OR Sangeet 6hr=1 OR Additional 3hr=1)
    - Photo Classic: Standard Photo=1 OR non-wedding events
    - Video Luxe: Cinema=1
    - Video Classic: Video Wedding Day/6hr/3hr=1 (without Cinema=1)
  * CSV source: ~/Downloads/Tools-Lead Sheet - Client Leads.csv
- before you deploy to Google Cloud Run, always have the user validate locally so we minimize wrong deployments and maximize true fix deployments.
- always offer a recommendation based on your analysis or follow best practices. minimize decisions I need to make.
- BROWSER AUTOMATION: Don't run Playwright browser automation unless explicitly requested - it disrupts the user's workflow. Use curl, wget, or other non-intrusive validation methods instead.
- never ever suggest a manual process. in situations where refresh tokens have expired, guide the user through the refresh process. manual processes are a big no-no.
- when you say 'ready for testing', how come I am catching 404 errors? always proactively check to verify what your saying is ready for testing is in fact true. the user shouldn't have to call out obvious 404 errors. proactively check always!
- LONG-RUNNING PROJECT HARNESS (AUTO-ENFORCED):
  * DETECTION: Any project with 3+ features, multi-session work, or complex implementation is "long-running"
  * ON SESSION START (MANDATORY):
    1. Check if project has `features.json` - if missing, CREATE IT immediately with feature list
    2. Check if `claude-progress.txt` exists - if missing, CREATE IT
    3. Read `claude-progress.txt` to understand where we left off
    4. Run `git status` and `git log --oneline -5` to understand current state
    5. Identify the NEXT incomplete feature from `features.json`
  * DURING SESSION (MANDATORY):
    1. Work on ONE feature at a time only
    2. Update `features.json` status as you complete features (use "passes": true/false)
    3. Test end-to-end BEFORE marking any feature complete - no premature completion
    4. Commit frequently with descriptive messages
  * ON SESSION END / BEFORE LEAVING (MANDATORY):
    1. Update `claude-progress.txt` with: what was done, what's next, any blockers
    2. Commit all work with clear message
    3. Leave codebase in main-branch-ready state (no broken code)
  * FILE FORMATS:
    - `features.json`: {"features": [{"name": "Feature Name", "description": "...", "steps": ["step1", "step2"], "passes": false}]}
    - `claude-progress.txt`: Plain text log with timestamps, work done, next steps
  * WHY JSON: More corruption-resistant than markdown for feature tracking
  * CRITICAL: Never declare project "complete" without verifying ALL features pass end-to-end
- fix the type errors..if you notice them be proactive and fix them
- always check to confirm that deployment works and that URLs do not lead to 404 errors.
- when releasing new functionality, always run it via localhost for my review and approval before deploying to Google Cloud Run.
- GOOGLE CLOUD RUN DEPLOYMENT (MANDATORY - NO VERCEL):
  * CRITICAL: ALL deployments MUST use Google Cloud Run
  * DO NOT use Vercel for any deployments, webhooks, or serverless functions
  * Vercel credentials have been REMOVED from ~/.credentials.env as of 2025-12-28
  * GCP Projects (use `gcloud run services list --project=<name>` to find services):
    - rpvfunctions: Main backend (18+ services - package-builder-api, studio-cockpit, internal-booking, stripe-webhook, etc.)
    - clientgalleries: Frontend (client-portal)
  * Use 'gcloud run deploy' CLI for ALL deployments
  * Always validate deployment URL works after deploy (no 404s)
  * If you see old Vercel references in code, migrate them to Cloud Run
  * Credentials master file: ~/.credentials.env (symlinked to iCloud - see CREDENTIALS STORAGE section)
- CLOUD RUN REGION POLICY:
  * MANDATORY: ALL Cloud Run services MUST deploy to us-east4 (production standard)
  * NEVER deploy to europe-west1, us-central1, or any other region
  * If you see services in other regions, migrate them to us-east4
  * cloudbuild.yaml files MUST specify --region=us-east4
  * Artifact Registry: use us-east4-docker.pkg.dev
  * NOTE: us-east4 was standardized on 2025-12-31 (production already on us-east4)
  * AUTO-CLEANUP POLICIES ACTIVE:
    - Cloud Storage buckets: 7-day auto-delete for build artifacts
    - Artifact Registry: Keep 10 recent images, delete untagged >7 days
- CLOUD BUILD SECRETS BEST PRACTICES (CRITICAL):
  * NEVER manually deploy Cloud Run services - ALWAYS use Cloud Build triggers or `gcloud builds submit`
  * Manual deploys via `gcloud run deploy --source` do NOT include secrets from Secret Manager
  * For Next.js NEXT_PUBLIC_* vars: MUST be passed as --build-arg during Docker build (baked at build time)
  * For server-only secrets: Use --update-secrets in the deploy step (mounted at runtime)
  * cloudbuild.yaml MUST use `entrypoint: bash` with script blocks for proper secret expansion:
    ```yaml
    - name: 'gcr.io/cloud-builders/docker'
      entrypoint: 'bash'
      args:
        - '-c'
        - |
          docker build \
            --build-arg "NEXT_PUBLIC_VAR=$${SECRET_NAME}" \
            -t image:tag .
      secretEnv: ['SECRET_NAME']
    ```
  * The `$$` syntax in YAML becomes `$` in bash, allowing secret expansion
  * ALWAYS grant Cloud Build service account (PROJECT_NUM@cloudbuild.gserviceaccount.com) access to secrets:
    `gcloud secrets add-iam-policy-binding SECRET_NAME --member="serviceAccount:PROJECT_NUM@cloudbuild.gserviceaccount.com" --role="roles/secretmanager.secretAccessor"`
  * After deployment, ALWAYS verify env vars are embedded by checking deployed JS bundles (for Next.js)- LOCAL VALIDATION WORKFLOW (MANDATORY for video-editing-workflow):
  * CRITICAL: NEVER deploy to Cloud Run without running local validation first
  * Prevents debugging-in-production (saves hours per deployment)
  * Script: ./scripts/local-validation.sh
  * Steps:
    1. Build Docker container locally
    2. Run pytest with real imports (not mocked dependencies)
    3. Validate on small event (BOOKING_ID=1140, 40 clips, DRY_RUN=true)
    4. Optional: Full validation with real Gemini API
    5. Deploy to Cloud Run ONLY after local validation passes
  * Pre-push hook: cp scripts/pre-push.template .git/hooks/pre-push && chmod +x .git/hooks/pre-push
  * Enforcement: Pre-push hook blocks push to main if validation fails
  * ROI: 80% faster deployment (1.25h vs 6h debugging cycles)
  * NEVER use --no-verify to bypass validation (defeats the purpose)
