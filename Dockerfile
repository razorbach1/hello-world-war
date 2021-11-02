FROM ubuntu
ADD /target/*.war /war_file/
CMD ["/bin/bash"]
