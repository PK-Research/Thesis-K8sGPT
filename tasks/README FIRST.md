# Setting up
1. Once connected, complete your VSCode setup
2. Ignore and pass anything related to git. There is no need to push anything.
3. Add any extensions you might require for your usability. The following research-relevant extensions are already installed:
- Docker
- Kubernetes
- Makefile Tools
- YAML
- Github Copilot
- Github Copilot Chat
4. Press F1 and start a bash terminal if you didn't start one in the setup.
5. Move to task1 folder with command:
cd task1*
7. Once in the task directory, run "make apply" to apply the configurations in ./manifests - folder.
8. To check verify if task is done correctly, run "make verify".
9. To delete configurations in ./manifests - folder, run "make delete".
10. Move to the next task. MAKE SURE TO RUN "make delete" BEFORE MOVING TO NEXT TASK! MAKE SURE TO CHANGE DIRECTORY!

## You can run K8sGPT with:
- To run a scan using LLM
k8sgpt analyze --explain

- To get the official documentation from Kubernetes:
k8sgpt analyze --explain --with-doc

-  For JSON formatting, use:
k8sgpt analyze --explain --output=json

For more info on and commands, see [K8sGPT Cheat Sheet.md](K8sGPT%20Cheat%20Sheet.md) in the upper directory.

# Instructions on how to proceed with the study:
- Complete one task at a time.
- Make sure your working directory is the current task directory (task1, task2, etc.)
- Run "make apply" to apply the current configurations to the cluster.
- After each task, run "make delete" to delete the applied configurations.

- You can talk aloud about your though processes or ideas as you complete the tasks.
- Using K8sGPT is encouraged.
- To use K8sGPT with LLM, run command "k8sgpt analyze --explain".
- View K8sGPT commands via "k8sgpt --h".

- You can use any external resources you want, including other AI-tools.

- You can alias kubectl to anything you want. For example: "alias k=kubectl".