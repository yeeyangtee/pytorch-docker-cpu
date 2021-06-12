Test image for trying out deployment of pytorch training jobs on Akash network.
Lots of inefficiencies and bad security practices but just a proof of concept..

Pytorch training has 3 main components:
- Getting Data
- Running model training script
- Saving trained model and retrieving model file.

Use wget to download the public dataset. Private ones could be hosted somewhere and downloaded in the same manner.
Model training script is just a .py file
Trained model gets saved on the deployment. Currently using SSH/SCP as a workaround to grab the trained model file. Pretty sure theres a better way to do it....

### TODOs
- Use smaller base image
- Alternatives to SSH for getting model file
- Currently num_workers for dataloader is set to 0, which is super inefficient. There is some compability issue between pytorch and kubernetes clusters. Can be fixed but i'm lazy.