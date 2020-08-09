FROM centos:latest
RUN yum install wget -y
RUN wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat/jenkins.repo
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
RUN yum install jenkins -y
RUN echo -e "jenkins ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
EXPOSE 8080
RUN yum install net-tools -y
RUN yum install git -y
RUN yum install sudo -y
RUN yum install java-1.8.0-openjdk -y
RUN yum install java-1.8.0-openjdk-devel -y

RUN echo -e "root ALL=(ALL:ALL)ALL" >> /etc/sudoers
USER root
RUN sudo curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl

RUN sudo chmod +x ./kubectl
RUN sudo mv ./kubectl /usr/local/bin/kubectl
COPY ca.crt /root/
COPY client.crt /root/
COPY client.key /root/
COPY config /root/.kube/
CMD java -jar /usr/lib/jenkins/jenkins.war
