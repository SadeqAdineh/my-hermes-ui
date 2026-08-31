─ dockerfile
      FROM nousresearch/hermes-agent:latest
      # Build the custom UI
      USER root
      RUN apt-get update && apt-get install -y git npm && \
          git clone https://github.com/przbadu/hermes-ui.git /tmp/hermes-ui && \
          cd /tmp/hermes-ui/app && \
          npm install && \
          npm run build && \
          mkdir -p /opt/hermes/web_dist_custom && \
          cp -r dist/* /opt/hermes/web_dist_custom/
      # Tell Hermes to serve our custom UI instead of the built-in one
      ENV HERMES_WEB_DIST=/opt/hermes/web_dist_custom
      # Disable the internal dashboard so it doesn't conflict
      ENV HERMES_DASHBOARD=0
