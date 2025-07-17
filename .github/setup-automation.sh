#!/bin/bash

# GitHub Actions Setup Script for Home Assistant Add-ons
# This script helps initialize the automation workflows

set -e

echo "🚀 Setting up GitHub Actions automation for Home Assistant Add-ons..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    print_error "This is not a git repository. Please run this script in your repository root."
    exit 1
fi

# Check if GitHub workflows directory exists
if [[ -d ".github/workflows" ]]; then
    print_status "GitHub workflows directory found"
else
    print_error "GitHub workflows directory not found. Make sure you've copied the .github directory."
    exit 1
fi

echo ""
echo "🔧 Checking repository configuration..."

# Check if repository has required files
required_files=(
    ".github/workflows/ci.yaml"
    ".github/workflows/deploy.yaml"
    ".github/workflows/security.yaml"
    ".github/workflows/dependencies.yaml"
    ".github/workflows/documentation.yaml"
    ".github/workflows/release.yaml"
    ".github/workflows/upstream-updates.yaml"
    ".github/workflows/quality-assurance.yaml"
    ".github/dependabot.yml"
    ".yamllint.yml"
    ".markdownlint.yml"
    ".pre-commit-config.yaml"
)

missing_files=()
for file in "${required_files[@]}"; do
    if [[ -f "$file" ]]; then
        print_status "Found $file"
    else
        missing_files+=("$file")
        print_error "Missing $file"
    fi
done

if [[ ${#missing_files[@]} -gt 0 ]]; then
    print_error "Some required files are missing. Please ensure all workflow files are in place."
    exit 1
fi

echo ""
echo "🏷️  Checking repository settings..."

# Get repository information
REPO_URL=$(git remote get-url origin 2>/dev/null || echo "")
if [[ -n "$REPO_URL" ]]; then
    # Extract owner/repo from URL
    if [[ "$REPO_URL" =~ github\.com[:/]([^/]+)/([^/.]+) ]]; then
        REPO_OWNER="${BASH_REMATCH[1]}"
        REPO_NAME="${BASH_REMATCH[2]}"
        print_status "Repository: $REPO_OWNER/$REPO_NAME"
    else
        print_warning "Could not parse repository URL: $REPO_URL"
    fi
else
    print_warning "No remote origin found"
fi

echo ""
echo "📋 Setup checklist:"

echo ""
print_info "Repository Configuration:"
echo "  □ Enable GitHub Actions in repository settings"
echo "  □ Enable Dependabot security updates"
echo "  □ Configure branch protection for main/master branch"
echo "  □ Enable 'Allow GitHub Actions to create and approve pull requests'"

echo ""
print_info "Optional Secrets (for enhanced features):"
echo "  □ SNYK_TOKEN - For Snyk security scanning"
echo "    Get token from: https://snyk.io/account/"

echo ""
print_info "First Steps:"
echo "  1. Commit and push these workflow files"
echo "  2. Go to your repository's Actions tab"
echo "  3. Enable workflows if prompted"
echo "  4. Run 'CI' workflow manually to test"

echo ""
print_info "Release Process:"
echo "  1. Use Actions → Release → Run workflow"
echo "  2. Select add-on and version type"
echo "  3. This will create a tag and GitHub release"
echo "  4. Deploy workflow runs automatically on release"

echo ""
print_info "Monitoring:"
echo "  □ Check Actions tab for workflow runs"
echo "  □ Monitor Security tab for vulnerability reports"
echo "  □ Review automated PRs from Dependabot and update workflows"

echo ""
echo "📚 Documentation:"
print_info "Read .github/AUTOMATION.md for detailed information about:"
echo "  • Workflow descriptions and triggers"
echo "  • Configuration options"
echo "  • Troubleshooting guides"
echo "  • Best practices"

echo ""
print_status "Setup verification complete!"

# Check if we can run a basic validation
echo ""
echo "🧪 Running basic validation..."

# Validate YAML files
if command -v yamllint &> /dev/null; then
    if yamllint .github/workflows/ &> /dev/null; then
        print_status "Workflow YAML files are valid"
    else
        print_warning "Some YAML files have issues. Run 'yamllint .github/workflows/' for details"
    fi
else
    print_info "Install yamllint to validate YAML files: pip install yamllint"
fi

# Check if pre-commit is available
if command -v pre-commit &> /dev/null; then
    print_status "Pre-commit is available"
    print_info "Run 'pre-commit install' to enable pre-commit hooks"
else
    print_info "Install pre-commit for local validation: pip install pre-commit"
fi

echo ""
print_status "🎉 GitHub Actions automation setup is ready!"
print_info "Push your changes and check the Actions tab to see the workflows in action."

echo ""
print_warning "Next steps:"
echo "  1. git add ."
echo "  2. git commit -m '🚀 Add GitHub Actions automation'"
echo "  3. git push"
echo "  4. Visit https://github.com/$REPO_OWNER/$REPO_NAME/actions"
