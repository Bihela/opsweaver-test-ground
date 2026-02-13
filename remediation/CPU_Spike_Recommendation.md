# CPU Spike Remediation

## Overview
This document outlines the recommendations and actions to take following observed CPU spikes related to GitHub Actions workflow changes in the `asp-cpuspiker-free-central` resource.

## Recommendations
1. **Monitor CPU Usage**: Closely monitor the CPU usage post-deployment changes and assess for further spikes.
2. **Analyze GitHub Actions Workflows**: Review actions in the workflows related to the recent commit that may be impacting CPU usage. Identify specific actions causing spikes.
3. **Optimize Workflow Configuration**: Adjust the configuration of manual triggers and build simulation steps to minimize unnecessary CPU load.
4. **Regular Review Process**: Establish a regular review process for workflow triggers to ensure optimal resource utilization and prevent spikes in CPU usage in future deployments.
5. **Scale Resources If Needed**: Consider scaling resources or implementing auto-scaling rules if high usage is expected and unavoidable due to business requirements.