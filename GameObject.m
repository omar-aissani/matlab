classdef GameObject < handle
    properties
        name (1, 1) string = "";
        tag (1, 1) string = "";
        % transform Transform = Transform();
        localTransform Transform = Transform();
        parent = [];
        children = [];
    end

    properties(SetAccess=protected, GetAccess=public)
       ID(1, 1) uint16;
    end
    
    properties (Dependent)
        Transform Transform;
    end

    methods
        % Constructor
        function obj = GameObject(name, localTransform)
            arguments
                name string = "";
                localTransform Transform = Transform();
            end
            obj = obj.SetID();
            if(name ~= "")
                obj.name = name;
            else
                obj.name = "Game Object (" + num2str(obj.ID) + ")";
            end
            obj.localTransform = localTransform;
            %obj.SetTransform();
        end

        % Static ID Setter
        function obj = SetID(obj)
            persistent ID
            if isempty(ID)
                ID = 1;
            end
            obj.ID = ID;
            ID = ID+1;
        end

        % Set Parent
        function obj = SetParent(obj, g)
            if(~isa(g, "GameObject"))
                error('Object must be of type "GameObject"');
            end
            obj.parent = g;
        end

        % Push Children
        function obj = PushChild(obj, g)
            if(~isa(g, "GameObject"))
                error('Object must be of type "GameObject"');
            end
            g = g.SetParent(obj);
            obj.children = [obj.children g];
            %g = g.SetTransform();
        end

        
        % % Set Global Transform
        % function obj = SetTransform(obj)
        %     HT = obj.localTransform.HT;
        %     obj_ = obj;
        %     while(~isempty(obj_.parent))
        %         obj_ = obj_.parent;
        %         HT = obj_.localTransform.HT * HT;
        %     end
        %     obj.transform = HT;
        % end

        % Get Global Transform
        function HT = get.Transform(obj)
            HT = obj.localTransform.HT;
            obj_ = obj;
            while(~isempty(obj_.parent))
                obj_ = obj_.parent;
                HT = obj_.localTransform.HT * HT;
            end
        end
       
        

        function Log(obj)
            fprintf("GameObject: %s", obj.name);
        end
    end
end