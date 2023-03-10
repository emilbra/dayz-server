# Some usefull commands

## Az cLi

|Command|Description|
|-------|-----------|
|``` az login ``` | logs you into azure. After doing this, Terraform can use the account to auth against Azure|
|``` az ad signed-in-user show ``` | shows information about the currently signed in user. |
|``` az ad signed-in-user show \| grep id ``` | gets the client Id for the currently signed in user. |
|``` az account show ``` | displays information about the subscripton(s) currently connected to. |
|``` az account show \| grep id ``` | displays the id of the subscripton(s) currently connected to. |
|``` az account show \| grep tenantId ``` | displays the tenantDd of the subscripton(s) currently connected to. |
