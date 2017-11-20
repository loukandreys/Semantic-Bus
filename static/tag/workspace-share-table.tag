<workspace-share-table class="containerV">

  <zenTable  if={!isEmpty} drag={false}  disallownavigation={true} disallowdelete={false}  clickClass={false} style="flex:1;background-color: rgb(238,242,249);" disallowcommand="true">
    <yield to="header">
      <div>Name</div>
      <div>Description</div>
    </yield>
    <yield to="row">
      <div style="width:30%">{name}</div>
      <div style="width:70%">{description}</div>
    </yield>
  </zenTable>
  <div if={isEmpty} class="containerH" style="flex-grow:1;justify-content:center;">
    <div class="containerV"  style="flex-basis:60%;justify-content:center;">
      <h4 style="font-size: 25pt;text-align: center;color: rgb(119,119,119);"> 
      Vous n'avez pas encore de workspaces partagés, ils apparaitront si d'autres utilisateurs decident de vous partager leur workspaces
      </h4>
    </div>
  </div>
  <script>

    this.isEmpty = false

    navigationClick(e) {
      console.log("test", e.item.rowid)
      var index = parseInt(e.item.rowid);
      let dataWithRowId =  this.tags.zentable.data[index];
      console.log("dataWithRowId", dataWithRowId, dataWithRowId.rowid)
      this.trigger('rowNavigation', dataWithRowId)
    }

    //console.log('mount opts :',this.opts);
    this.refreshZenTableShare = function (data) {
      console.log('view UPDATE refreshZenTableShare', data);
      if(data.length > 0){
        this.isEmpty = false
        this.tags.zentable.data = data;
      }else{
        this.isEmpty = true
      }
      this.update()
    }.bind(this);


    this.on('mount', function (args) {

      RiotControl.on("filterCards", function(e){
        console.log("in filtercard trigger")
        if(e.code == "Backspace"){
          this.tags.zentable.data = this.data
          this.tags.zentable.data = sift({name: {$regex: re}  }, this.tags.zentable.data);
        }
        let test = $(".champ")[0].value
        var re = new RegExp(test, 'gi');
        this.tags.zentable.data = sift({name: {$regex: re}  }, this.tags.zentable.data);
        this.update()
      }.bind(this))

      this.tags.zentable.on('rowNavigation', function (data) {
        console.log("rowNavigation", data);
        RiotControl.trigger('workspace_current_select', data);
      }.bind(this));

      RiotControl.on('workspace_share_collection_changed', this.refreshZenTableShare);

      RiotControl.trigger('workspace_collection_share_load');

      //this.refresh();
    });
    this.on('unmount', function (args) {

      RiotControl.off('workspace_share_collection_changed', this.refreshZenTableShare);

    });
  </script>
  <style>
  .champ {    
      color: rgb(220,220,220);
      width: 50vw;
      height: 38px;
      border-radius: 20pt;
      border-width: 0;
      font-size: 1em;
    }
   </style>
</workspace-share-table>
