## Dockerfile Build Times

### Current Build Time
The build time for the current Dockerfile is **674.4 seconds**.

---

### How to Improve Build Times
To improve build times:

1. **Optimize the Order of Instructions**:
   - Place frequently changing instructions (e.g., `COPY` commands for source code) **after** stable instructions to maximize layer caching.
   - Combine related commands into a single `RUN` instruction.

2. **Use Smaller Base Images**:
   - Choose minimal base images (e.g., `alpine` or `distroless`) to reduce image size and build time.

3. **Utilize Multi-Stage Builds**:
   - Separate the build and runtime stages 

4. **Use Precompiled Binaries**:
   - Use precompiled binaries instead of building dependencies from source to save time.

5. **Enable Docker Layer Caching in CI/CD Pipelines**:
   - Configure CI/CD pipelines to reuse cached layers from previous builds, speeding up subsequent builds.

---

## Recommendations to Remediate CVEs
How to address CVEs

1. **Update Base Image**:
   - Switch to a more secure base image.
   - Regularly update the base image to ensure the latest security patches are applied.

2. **Use Minimal Base Images**:
   - Switch to slimmed-down base images (e.g., `alpine`, `debian-slim`, or `distroless`) to reduce the attack surface.

3. **Pin Dependencies to Known Secure Versions**:
   - Use specific versions of packages and libraries to avoid introducing unpatched vulnerabilities.

4. **Remove Unnecessary Packages**:
   - Unistall or avoid installing packages that aren't required or unused tools, libraries, and files from the image to reduce exposure to vulnerabilities.


5. **Implement Runtime Security**:
   - Run containers with the least privileges using the `--user` flag and avoid running as root.
   - Use security profiles to restrict container capabilities.

6. **Implement CICD scanning**:
   - Automate scans and vulnerability checks by integrationg vuln scanning in your CICD pipeline. Tools like **Trivy**, **Anchore**, or **Snyk**. You can filter for only `--high` and `--critical` to scan for only high and critical vulns
   - You can implement image scanning in the CICD pipeline also.
   - Use security profiles like **AppArmor** or **Seccomp** to restrict container capabilities.

7. **Build Snyk integrations that upgrades vulns when found**:
    - Fix Critical and High-Severity Vulnerabilities: Prioritize fixing high and critical vulnerabilities by implementing Snyk's capability to look for upgrades to vulns found. Make sure to use the flag `--stable` to set the upgrades to stable versions.
   

---

## What I would do to avoid deploying malicious packages


1. **Use Trusted Sources**:
    - I would use official images from trusted repos like, Amazon ECR, Docker hub and Red Hat.
    - Install dependencies from only trusted package managers and avoid using unverified or unofficial packages.

2. **Pin Versions**:
    - I would specify exact versions for packages (e.g requirements.txt) like `requests==2.25.1 flask==1.1.2`.
    - Avoid using latest versions images and packages.

3. **Scan Dependencies**:
    - I already alluded to this, but scanning dependencies to detect vulns is a good way to avoid deploying malicious packages

4. **Use Private Package Repos**:
    - Hosting ones dependencies in private repos (e.g Nexus, Artifactory). This allows you to control which packages are approved for us.

5. **Automate Scanning in CICD Pipelines**:
    - Integrate vulnerabiity scanning into your CICD pipelines to automatically detect malicious and or vulnerable packages before deployment. Tools like `snyk` and `trivy`

6. **Educate Developers**:
    - A not so talked about option, educating and training developers on secure coding practice(s), importance of using trusted sources. 