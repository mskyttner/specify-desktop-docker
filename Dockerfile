FROM openjdk:jre
ADD ./Specify_unix_64.sh /usr/src/specify/
WORKDIR /usr/src/specify
RUN chmod +x Specify_unix_64.sh
# run the installer quietly, using defaults, with progress logged to console
RUN ./Specify_unix_64.sh -q -console
RUN rm ./Specify_unix_64.sh
CMD ["Specify"]
