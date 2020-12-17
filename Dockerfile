FROM openjdk:11

RUN apt-get update && apt-get install -y wget tar unzip git && rm -rf /var/lib/apt/lists/*
RUN wget -O - https://debian.neo4j.com/neotechnology.gpg.key | apt-key add -
RUN echo 'deb https://debian.neo4j.com stable latest' | tee -a /etc/apt/sources.list.d/neo4j.list
RUN apt-get update && apt-get install -y neo4j=1:4.1.3
RUN git clone https://github.com/Timothy-G-Griffin/build_databases.cst.cam.ac.uk
WORKDIR /build_databases.cst.cam.ac.uk
ADD IMDb_graph IMDb_graph
RUN sed -i 's/graph.db/neo4j/g' neo4j_load.sh
RUN sed -i 's+\$NEO4JBINPATH+/usr/bin+g' neo4j_load.sh
RUN sed -i 's+\$NEO4JDATAPATH+/var/lib/neo4j/data/databases+g' neo4j_load.sh
RUN ./neo4j_load.sh 
WORKDIR /usr/bin