New-Window {
@'
<ScrollViewer>
    <ScrollViewer.Resources>
            <DataTemplate 
        		x:Key = "ColumnTemplate">
        	  <TreeViewItem Header="{Binding Column}" />
        	</DataTemplate>  
            <DataTemplate 
        		x:Key = "ParameterTemplate">
        	  <TreeViewItem Header="{Binding Parameter}" />
        	</DataTemplate>
            <DataTemplate 
        		x:Key = "KeysTemplate">
        	  <TreeViewItem Header="{Binding COLUMN_NAME}" />
        	</DataTemplate>        	
        	<DataTemplate 
        		x:Key = "OperationsTemplate">
        	  <TreeViewItem Header="{Binding operation}" />
        	</DataTemplate>  
            <DataTemplate 
        		x:Key = "RelationsTemplate">
        	  <TreeViewItem Header="{Binding Relation}" />
        	</DataTemplate>
            <DataTemplate 
        		x:Key = "TableTemplate" >
        		<TreeViewItem Header="{Binding Table}" >
                    <TreeViewItem Header="Columns"
                        ItemsSource="{Binding Table2Column}" 
                        ItemTemplate="{StaticResource ColumnTemplate}" />
                    <TreeViewItem Header="Keys"
                        ItemsSource="{Binding Table2Keys}" 
                        ItemTemplate="{StaticResource KeysTemplate}" />
                    <TreeViewItem Header="Relations"
                        ItemsSource="{Binding Table2Relations}" 
                        ItemTemplate="{StaticResource RelationsTemplate}" />
                    <TreeViewItem Header="Operations"
                        ItemsSource="{Binding Table2Operations}" 
                        ItemTemplate="{StaticResource OperationsTemplate}" />
                </TreeViewItem>             
        	</DataTemplate>
            <DataTemplate 
        		x:Key = "ViewTemplate" >
        		<TreeViewItem Header="{Binding Table}" >
                    <TreeViewItem Header="Columns"
                        ItemsSource="{Binding View2Column}" 
                        ItemTemplate="{StaticResource ColumnTemplate}" />
                </TreeViewItem>             
        	</DataTemplate>        	
        	<DataTemplate 
        		x:Key = "RoutineTemplate" >
        		<TreeViewItem Header="{Binding Routine}" >
                    <TreeViewItem Header="Parameters"
                        ItemsSource="{Binding Routine2Parameter}" 
                        ItemTemplate="{StaticResource ParameterTemplate}" />
                </TreeViewItem>             
        	</DataTemplate>
            <DataTemplate 
        		x:Key = "DatabaseTemplate">
        		<TreeViewItem Header="{Binding Database}">
                    <TreeViewItem 
                        Header = "Tables"
                        ItemsSource="{Binding Database2Table}" 
        		        ItemTemplate="{StaticResource TableTemplate}" />
                    <TreeViewItem 
                        Header = "Views"
                        ItemsSource="{Binding Database2View}" 
        		        ItemTemplate="{StaticResource ViewTemplate}" />
                    <TreeViewItem 
                        Header = "Routines"
                        ItemsSource="{Binding Database2Routine}" 
        		        ItemTemplate="{StaticResource RoutineTemplate}" />   
                </TreeViewItem> 
        	 </DataTemplate>
    </ScrollViewer.Resources>
    <TreeView 
    	ItemsSource="{Binding Database}"
    	ItemTemplate="{StaticResource DatabaseTemplate}" >
    </TreeView>
</ScrollViewer>
'@
} -DataContext $ds -Height 300 -Width 300 -WindowStartupLocation CenterScreen  -show