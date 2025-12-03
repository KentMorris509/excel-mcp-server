# Use Python 3.10 as base image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Install uv for package management
RUN pip install --no-cache-dir uv

# Copy project files
COPY pyproject.toml uv.lock README.md ./
COPY src/ ./src/

# Install dependencies using uv
RUN uv pip install --system -e .

# Create directory for Excel files
RUN mkdir -p /excel_files

# Set environment variable for Excel files path
ENV EXCEL_FILES_PATH=/excel_files

# Expose port for HTTP transports
EXPOSE 8017

# Default command runs stdio transport
ENTRYPOINT ["excel-mcp-server"]
CMD ["stdio"]
