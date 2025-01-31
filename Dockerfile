# Use an R base image
FROM rocker/r-base

# Run commands as root
USER root

# Create the .cloudshell directory, no-apt-get-warning file, update package list,
# install aptitude, additional libraries, Python, pip, and clean up in one RUN command to reduce layers
RUN mkdir -p ~/.cloudshell/ && \
    touch ~/.cloudshell/no-apt-get-warning && \
    apt-get update -y && \
    apt-get install -y aptitude python3 python3-pip git && \
    aptitude install -y libgdal-dev libproj-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    pip3 install dendropy scipy matplotlib numpy seaborn biopython ete3 phylotrackpy pandas --break-system-packages

# Install R packages
RUN Rscript -e "install.packages(c('codetools', 'dplyr', 'gen3sis', 'gdistance', 'ggplot2', 'Matrix', 'raster', 'rgdal', 'remotes')); library(remotes); install_github('project-gen3sis/R-package'); install_github('cran/rgdal');"
