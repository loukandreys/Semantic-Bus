<workspace-editor>
  <!--<div class="containerV" style="flex-grow:1">-->
    <div class="commandBar2 containerHWorkspace">
      <div></div>
      <div class="title-bar">{innerData.name}</div>
      <div></div>
      <div class="containerH commandGroup">
          <div onclick={editClick}  class="commandButton" if={innerData.mode=="read"}>
            edit
          </div>
          <div onclick={graphClick}  class="commandButton" if={innerData.mode=="read"}>
            graph
          </div>
          <div onclick={cancelClick}  class="commandButton" if={innerData.mode=="edit" || innerData.mode=="init"}>
            cancel
          </div>
          <div onclick={persistClick}  class="commandButton" if={innerData.mode=="edit" || innerData.mode=="init"}>
            save
          </div>
      </div>
    </div>
    <div>
        <div class=" containerH" style="justify-content: flex-start!important">
          <div class="{color1}" if= {componentView}  onclick={goComponent}>Composant(s)</div>
          <div class="{color2}" if= {userView} onclick={goUser}>Utilisateur(s)</div>
          <div class="{color3}" if= {DescriptionView} onclick={goDescription}>Déscription</div>
        </div>
        <div show={modeComponentList}>
          <zenTable  style="flex:1"  css="background-color:white!important;color: #3883fa;" disallowcommand={innerData.mode=="read"} >
              <yield to="header">
                <div>nom</div>
                <div>composant technique</div>
              </yield>
              <yield to="row">
                <div style="width:20%">{name}</div>
                <div style="width:20%">{type}</div>
                <div style="width:60%">{description}</div>
              </yield>
          </zenTable>
        </div>
        <div show={modeUserList}>
          <zenTable title="" style="flex:1" disallownavigation="true"   css="background-color:white!important;color: #3883fa;"    disallowcommand={innerData.mode=="read"} >
              <yield to="header" >
                <div>email</div>
                <div>role</div>
              </yield>
              <yield to="row">
                <div style="width:100%">{email}</div>
                <div style="width:100%">{role}</div>
              </yield>
          </zenTable>
        </div>
        <div show={modeUserDescription} class="description-worksapce">
          <label style="padding-top:3vh">{labelInputName} </label>
          <input readonly={innerData.mode=="read"} class={readOnly : innerData.mode=="read", description-worksapce-input : innerData.mode=="edit"} name="workspaceNameInput" type="text" placeholder="nom du workspace" value="{innerData.name}"></input>
           <label style="padding-top:3vh" >{labelInputDesc} </label>
          <input readonly={innerData.mode=="read"} class={readOnly : innerData.mode=="read",  description-worksapce-input : innerData.mode=="edit"} name="workspaceDescriptionInput" type="text" placeholder="description du workspace" value="{innerData.description}"></input>
        </div>
      <!--<span>composant d'initialisation : </span>
      <span>{innerData.firstComponent.type} : {innerData.firstComponent.desription}</span>-->

      <!-- <div class="containerH" show={innerData.mode=="read"}>
        <div class="containerV" style="flex-grow:1">
          <div class="commandBar containerH">
            <div class="commandTitle">
              composants
            </div>
          </div>
          <div class="containerV" style="flex-grow:1">
            <div class="selector" each={innerData.components} onclick={componentClick}>
              {type} : {name}
            </div>
          </div>
        </div>
      </div> -->
    </div>
  <!--</div>-->
  <style>

  .description-worksapce-input {
    text-align: left;
    border-bottom: 1px solid #3883fa !important;
    margin-top: ;
    border: none;
    padding: 10px;
    font-size: 20px;

  }

.description-worksapce{
  display: flex;
  flex-direction: column;
  width: 60%;
  padding: 5%;
}

  .title-bar {
    color: #3883fa;
    flex: 2;
  }

  .containerHWorkspace {
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    align-items: stretch;
    overflow-y: hidden;
}


.commandBar2 {
    justify-content: flex-end;
    background-color: white;
    color: #3883fa;
    justify-content: space-between;
    padding: 2px;
    overflow-y: visible;
}

.white-bar {
  background-color:white!important;
}
  .white {
    width: 15%;
    text-align: center;
    border-bottom-style: solid;
    cursor: pointer;
    color: #3883fa;
    border: none;
    border-radius: 0px;
  }

  .blue {
    width: 15%;
    text-align: center;
    border-bottom-style: solid;
    border-bottom: 1.4px solid #3883fa !important;
    cursor: pointer;
    color: #3883fa;
    border: none;
    border-radius: 0px;
  }
  </style>
<script>
  this.labelInputName = "Nom"
  this.labelInputDesc = "Description"
  this.componentView = true;
  this.userView = true;
  this.DescriptionView = true;
  this.color1 = "blue";
  this.color2 = "white";
  this.color3 = "white";
  this.innerData={}
  this.modeUserList = false;
  this.modeComponentList = true;
  this.modeUserDescription = false;
  this.title = "Workspace"
  this.persist=function(){
    this.persistClick();
  }


  goDescription(e){
    this.modeUserList = false;
    this.modeComponentList = false;
    this.modeUserDescription = true;
    this.color2 = "white"
    this.color1 = "white"
    this.color3 = "blue"
    this.update()
  }.bind(this)

  goUser(e){ 
    this.modeUserList = true;
    this.modeComponentList = false;
    this.modeUserDescription = false;
    this.color2 = "blue"
    this.color1 = "white"
    this.color3 = "white"
    console.log(this.workspace._id.$oid)
    //RiotControl.trigger('load_all_profil_by_workspace', {_id: this.workspace._id.$oid})
  }.bind(this)

  goComponent(e){
    this.modeUserList = false;
    this.modeComponentList = true;
    this.modeUserDescription = false;
    this.color2 = "white"
    this.color1 = "blue"
    this.color3 = "white"
  }.bind(this)


  this.persistClick = function(e){
    //console.log(this.tags.workspaceName);
    this.componentView = true;
    this.userView = true;
    this.DescriptionView = true;
    RiotControl.trigger('workspace_current_updateField',{field:'name',data:this.innerData.name});
    RiotControl.trigger('workspace_current_updateField',{field:'description',data:this.innerData.description});
    RiotControl.trigger('workspace_current_persist');
  }

  editClick(e){
    //console.log('EDIT');
    RiotControl.trigger('workspace_current_edit');
    this.labelInputName = "Modifier le nom du workspace"
    this.labelInputDesc = "Modifier la déscription du workspace "
    console.log(this.innerData.mode)
  }

  graphClick(e){
    //console.log('EDIT');
    RiotControl.trigger('workspace_current_graph');
  }

  cancelClick(e){
    this.componentView = true;
    this.userView = true;
    this.DescriptionView = true;
    RiotControl.trigger('workspace_current_cancel');
    this.labelInputName = "Nom"
    this.labelInputDesc = "Description"
  }

  RiotControl.on('share_change',function(data){
      console.log('view',data);
      this.tags.zentable[1].data.push(data);
      this.update();
      data = null;
  }.bind(this));


  // componentClick(e){
  //   //console.log(e.item);
  //   RiotControl.trigger('item_current_click',e.item);
  // }

  this.on('mount', function () {
    //console.log('workspaceEditor mount');

    /// COMPONENT

    console.log(this.tags.zentable[0])
    this.tags.zentable[0].on('addRow',function(message){
      console.log("trigger")
      this.componentView = true;
      this.userView = false;
       this.DescriptionView = false;
      RiotControl.trigger('workspace_current_add_component',message);
    }.bind(this));
    
    this.tags.zentable[0].on('delRow',function(message){
      console.log('delRow');
      RiotControl.trigger('workspace_current_delete_component',message);
    }.bind(this));
    this.tags.zentable[0].on('rowNavigation',function(data){
      //console.log(data);
      RiotControl.trigger('item_current_click',data);
      //this.trigger('selectWorkspace');
    }.bind(this));

    RiotControl.on('workspace_current_changed',function(data){
      console.log('workspace-editor; change model : ',data);
      this.workspace = data
      this.innerData = data;
      this.tags.zentable[0].data=data.components;
      this.update();
    }.bind(this));


    ////USER 

    RiotControl.on('all_profil_by_workspace_loaded',function(data){
      console.log('all_profil_by_workspace_loaded-WORKSPACE-EDITOR-TAG, change model : ',data);
      //this.innerDataUser = data;
      this.tags.zentable[1].data=data;
      this.update();
    }.bind(this));

    this.tags.zentable[1].on('addRow',function(message){
        this.componentView = false;
        this.userView = true;
        this.DescriptionView = false;
        RiotControl.trigger('workspace_current_add_user',message);
    }.bind(this));

    

    ///HEADER PAGE
    
    this.workspaceNameInput.addEventListener('change',function(e){
      this.innerData.name=e.currentTarget.value;
    }.bind(this));

    this.workspaceDescriptionInput.addEventListener('change',function(e){
      this.innerData.description=e.currentTarget.value;
    }.bind(this));

    //RiotControl.trigger('workspace_current_refresh');


  });
</script>

</workspace-editor>

<!-- modifier -->
<!-- 
<input readonly={innerData.mode=="read"} class={readOnly : innerData.mode=="read"} name="workspaceNameInput" type="text" placeholder="nom du workspace" value="{innerData.name}"></input>
<input readonly={innerData.mode=="read"} class={readOnly : innerData.mode=="read"} name="workspaceDescriptionInput" type="text" placeholder="description du workspace" value="{innerData.description}"></input> -->
