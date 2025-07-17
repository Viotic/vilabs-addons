# GitHub Actions & Automation Guide

This repository includes a comprehensive set of GitHub Actions workflows to automate various aspects of Home Assistant add-on development and maintenance. This guide explains what each workflow does and how to use them effectively.

## 🔄 Workflow Overview

### Core Workflows

#### 1. **CI (Continuous Integration)** - `.github/workflows/ci.yaml`
**Triggers:** Push to main/master, Pull requests, Manual dispatch

**What it does:**
- Detects changed add-ons automatically
- Runs comprehensive linting (YAML, Markdown, JSON, Hadolint)
- Validates add-on configurations
- Builds Docker images for all supported architectures
- Uses build caching for faster subsequent builds

**Features:**
- Matrix builds for multiple architectures (aarch64, amd64, armv7)
- Parallel execution for faster feedback
- Comprehensive validation using Home Assistant tools

#### 2. **Deploy** - `.github/workflows/deploy.yaml`
**Triggers:** GitHub releases, Manual dispatch

**What it does:**
- Builds and publishes Docker images to GitHub Container Registry
- Supports stable, beta, and edge releases
- Tags images appropriately for different environments
- Handles multi-architecture builds

**Usage:**
Create a release through GitHub UI or use the Release workflow

#### 3. **Release Management** - `.github/workflows/release.yaml`
**Triggers:** Manual dispatch with add-on and version type selection

**What it does:**
- Automatically calculates new version numbers (patch/minor/major)
- Updates configuration files
- Generates changelog from commits
- Creates Git tags and GitHub releases
- Publishes release notes

**Usage:**
1. Go to Actions → Release → Run workflow
2. Select the add-on to release
3. Choose version bump type (patch/minor/major)

### Security & Quality

#### 4. **Security Scanning** - `.github/workflows/security.yaml`
**Triggers:** Daily schedule, Push/PR, Manual dispatch

**What it does:**
- **Snyk Security Scanning:** Code and dependency vulnerability scanning
- **Trivy Container Scanning:** Container image vulnerability scanning
- **CodeQL Analysis:** Static code analysis for security issues
- Uploads results to GitHub Security tab

**Setup Required:**
- Add `SNYK_TOKEN` secret for Snyk scanning
- GitHub CodeQL is free for public repositories

#### 5. **Quality Assurance** - `.github/workflows/quality-assurance.yaml`
**Triggers:** Push/PR, Weekly schedule, Manual dispatch

**What it does:**
- Pre-commit hook validation
- Shellcheck for shell scripts
- Add-on configuration validation
- Image size monitoring
- Performance testing (startup time)
- Documentation completeness checks

### Automation & Maintenance

#### 6. **Dependency Updates** - `.github/workflows/dependencies.yaml`
**Triggers:** Weekly schedule (Mondays), Manual dispatch

**What it does:**
- Updates base Docker images automatically
- Monitors Alpine package versions
- Auto-merges safe Dependabot PRs
- Creates PRs for manual review when needed

#### 7. **Upstream Updates** - `.github/workflows/upstream-updates.yaml`
**Triggers:** Daily schedule, Manual dispatch

**What it does:**
- Monitors upstream project releases (e.g., Open WebUI)
- Automatically creates PRs when new versions are available
- Includes upstream release notes and changelog
- Updates Dockerfiles to use specific versions

#### 8. **Documentation** - `.github/workflows/documentation.yaml`
**Triggers:** Push to main, Daily schedule, Manual dispatch

**What it does:**
- Updates README shields with current versions
- Validates internal documentation links
- Updates repository statistics
- Ensures all required documentation files exist

## 🔧 Configuration Files

### Dependabot - `.github/dependabot.yml`
Automatically creates PRs for:
- GitHub Actions updates
- Docker base image updates
- Python dependency updates (pip)
- NPM package updates

### Linting & Quality
- **`.yamllint.yml`** - YAML linting rules
- **`.markdownlint.yml`** - Markdown linting rules
- **`.pre-commit-config.yaml`** - Pre-commit hooks for code quality

### Issue Templates - `.github/ISSUE_TEMPLATE/`
- **Bug Report** - Structured bug reporting
- **Feature Request** - Enhancement suggestions
- **Support Question** - Help and configuration questions

### Pull Request Template - `.github/pull_request_template.md`
Standardized PR format with checklists for different types of changes.

## 🚀 Getting Started

### 1. **Initial Setup**

1. **Enable GitHub Actions** in your repository settings
2. **Add required secrets** (if using Snyk):
   ```
   SNYK_TOKEN - Your Snyk authentication token
   ```
3. **Enable Dependabot** alerts and security updates
4. **Configure branch protection** on main/master branch

### 2. **First Release**

1. Make sure your add-on has proper version in `config.yaml`
2. Run the Release workflow to create your first release
3. This will trigger the Deploy workflow automatically

### 3. **Daily Operations**

The workflows will handle most maintenance automatically:
- **Security scans** run daily
- **Dependency updates** run weekly
- **Upstream checks** run daily
- **Documentation updates** run daily

### 4. **Manual Operations**

Use manual dispatch for:
- **Immediate security scan** after dependency changes
- **Release creation** when ready to publish
- **Force upstream check** when you know there's an update
- **Documentation refresh** after major changes

## 📊 Monitoring & Notifications

### GitHub Security Tab
- View security scan results
- Track vulnerability trends
- Manage security advisories

### Actions Tab
- Monitor workflow runs
- View build logs and errors
- Track performance metrics

### Pull Requests
- Automated dependency updates
- Upstream version updates
- Documentation updates

## 🛠 Customization

### Adding New Add-ons

1. **Create add-on directory** with required files
2. **Update workflow matrices** if the add-on has special requirements
3. **Add to documentation** workflows for shield generation
4. **Configure upstream monitoring** if applicable

### Modifying Schedules

Edit the `cron` expressions in workflow files:
- `0 6 * * *` - Daily at 6 AM UTC
- `0 9 * * 1` - Weekly on Monday at 9 AM UTC
- `0 2 * * *` - Daily at 2 AM UTC

### Custom Security Scans

Add additional security tools by modifying `.github/workflows/security.yaml`:
- Add new scanning tools
- Configure custom vulnerability databases
- Set up notifications for critical issues

## 🔍 Troubleshooting

### Common Issues

1. **Build failures** - Check Docker base image availability
2. **Permission errors** - Verify GITHUB_TOKEN permissions
3. **Rate limiting** - Some checks may hit API limits on busy repositories
4. **Large images** - Monitor image sizes in Quality Assurance workflow

### Debugging

1. **Enable debug logging** by setting `ACTIONS_STEP_DEBUG=true` repository secret
2. **Check workflow logs** in the Actions tab
3. **Validate configurations** locally before pushing
4. **Use manual dispatch** to test specific workflows

## 📈 Best Practices

### Security
- Regularly review and update base images
- Monitor security scan results
- Keep dependencies up to date
- Use semantic versioning for releases

### Development
- Use feature branches for development
- Write meaningful commit messages
- Update documentation with changes
- Test changes locally before pushing

### Maintenance
- Review automated PRs promptly
- Monitor workflow success rates
- Update workflow configurations as needed
- Keep issue templates current with project needs

## 🤝 Contributing

When contributing to this repository:
1. Follow the established patterns in existing workflows
2. Test changes in a fork first
3. Update this documentation for new features
4. Consider security implications of workflow changes

This automation setup provides a robust foundation for maintaining Home Assistant add-ons with minimal manual intervention while ensuring high quality and security standards.
