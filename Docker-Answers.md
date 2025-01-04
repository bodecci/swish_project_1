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

You can manually trigger the pipeline in the repo and will see the build time for the image, tagging the image and publish to docker hub all take about 40secs.