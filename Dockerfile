FROM rocker/r-ver:4.3

# Dependencies for some R packages
# Use -y for non-interactive installation (no prompt)
RUN apt-get update
RUN apt-get install -y libssl-dev libsodium-dev

# Install R packages
ENV RENV_VERSION 1.0.5
RUN R -e "install.packages('renv', repos = c(CRAN = 'https://cloud.r-project.org'))"

# ENV RENV_PATHS_LIBRARY renv/library

COPY renv.lock renv.lock
COPY .renvignore .renvignore
RUN mkdir -p renv
COPY .Rprofile .Rprofile
COPY renv/activate.R renv/activate.R
COPY renv/settings.json renv/settings.json
RUN R -e 'renv::restore()'

# Copy files into docker image
COPY app.R app.R
COPY plumber.R plumber.R

EXPOSE 80

ENTRYPOINT ["Rscript", "app.R"]
