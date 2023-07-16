classdef Cube

    properties
        height double {mustBeFinite}
        width double {mustBeFinite}
        depth double {mustBeFinite}
        HT(4, 4) double = eye(4);
        type {mustBeMember(type, {'center', 'bottom'})} = 'bottom';

        FaceColor(1, 3) double = [1 0 1];
        FaceAlpha(1, 1) double = 1;
        LineColor(1, 3) double = [0 0 0];
        LineAlpha(1, 1) double = 1;
        LineWidth(1, 1) double = 0.5;
        LineStyle = '-';%'none';
        ax
    end

    properties (GetAccess = public, SetAccess = protected)
        graphics
        faces
        isVisible logical
    end

    methods
        function obj = Cube(height, width, depth)
            arguments
                height double {mustBeFinite} = 1;
                width double {mustBeFinite} = 1;
                depth double {mustBeFinite} = 1;
            end
            obj.height = height;
            obj.width = width;
            obj.depth = depth;
            obj = obj.UpdatePoints();
        end

        function obj = UpdatePoints(obj)
            % Local Variable
            h = obj.height;
            w = obj.width;
            l = obj.depth;
            
            % Top Face
            obj.faces.top.X = w/2 * [1 -1 -1 1];
            obj.faces.top.Y = l/2 * [1 1 -1 -1];
            obj.faces.top.Z = h/2 * [1 1 1 1];
            % Bottom Face
            obj.faces.bottom.X = w/2 * [1 -1 -1 1];
            obj.faces.bottom.Y = l/2 * [1 1 -1 -1];
            obj.faces.bottom.Z = - h/2 * [1 1 1 1];
  
            % Front Face
            obj.faces.front.X = w/2 * [1 -1 -1 1];
            obj.faces.front.Y = l/2 * [1 1 1 1];
            obj.faces.front.Z = h/2 * [1 1 -1 -1];
            % Back Face
            obj.faces.back.X = w/2 * [1 -1 -1 1];
            obj.faces.back.Y = -l/2 * [1 1 1 1];
            obj.faces.back.Z = h/2 * [1 1 -1 -1];

            % Right Face
            obj.faces.right.X = w/2 * [1 1 1 1];
            obj.faces.right.Y = l/2 * [1 1 -1 -1];
            obj.faces.right.Z = h/2 * [1 -1 -1 1];
            % Right Face
            obj.faces.left.X = -w/2 * [1 1 1 1];
            obj.faces.left.Y = l/2 * [1 1 -1 -1];
            obj.faces.left.Z = h/2 * [1 -1 -1 1];

            if obj.type == "bottom"
                obj.faces.front.Z = h * [1 1 0 0];
                obj.faces.back.Z = h * [1 1 0 0];
                obj.faces.top.Z = h * [1 1 1 1];
                obj.faces.bottom.Z = h * [0 0 0 0];
                obj.faces.right.Z = h * [1 0 0 1];
                obj.faces.left.Z = h * [1 0 0 1];
            end
            
            facesNames = ["bottom", "top", "front", ...
                "back","right", "left"];
            for j=1:6
                faceName = facesNames(j);
                X = obj.faces.(faceName).X;
                Y = obj.faces.(faceName).Y;
                Z = obj.faces.(faceName).Z;
                for i = 1:length(X)
                    p = [X(i); Y(i); Z(i)];
                    p_ = obj.HT(1:3, 4) + obj.HT(1:3, 1:3)*p;
                    X(i) = p_(1);
                    Y(i) = p_(2);
                    Z(i) = p_(3);
                end
                obj.faces.(faceName).X = X;
                obj.faces.(faceName).Y = Y;
                obj.faces.(faceName).Z = Z;
            end
            
        end

        function obj = UpdateGraphics(obj)
            facesNames = ["bottom", "top", "front", ...
                "back","right", "left"];
            for i=1:6
                faceName = facesNames(i);
                obj.graphics.(faceName).XData = obj.faces.(faceName).X;
                obj.graphics.(faceName).YData = obj.faces.(faceName).Y;
                obj.graphics.(faceName).ZData = obj.faces.(faceName).Z;
                
            end
        end

        function obj = Create(obj)
            obj = obj.UpdatePoints();
            ax_ = obj.ax;
            if(isempty(ax_))
                ax_ = gca;
            end
            
            facesNames = ["bottom", "top", "front", ...
                "back","right", "left"];
            for i=1:6
                faceName = facesNames(i);
                X = obj.faces.(faceName).X;
                Y = obj.faces.(faceName).Y;
                Z = obj.faces.(faceName).Z;
                obj.graphics.(faceName) = fill3(ax_, X, Y, Z, 'g');
                obj.graphics.(faceName).FaceColor = obj.FaceColor;
                obj.graphics.(faceName).FaceAlpha = obj.FaceAlpha;
                obj.graphics.(faceName).EdgeColor = obj.LineColor;
                %obj.graphics.(faceName).LineAlpha = obj.LineAlpha;
                obj.graphics.(faceName).LineWidth = obj.LineWidth;
                obj.graphics.(faceName).LineStyle = obj.LineStyle;
                obj.graphics.(faceName).HitTest = 'off';
            end
            
        end

        function obj = Show(obj)
            obj.isVisible = true;
            facesNames = ["bottom", "top", "front", ...
                "back","right", "left"];
            for i=1:6
                faceName = facesNames(i);
                obj.graphics.(faceName).Visible = 'on';
            end
        end

        function obj = Hide(obj)
            obj.isVisible = false;
            facesNames = ["bottom", "top", "front", ...
                "back","right", "left"];
            for i=1:6
                faceName = facesNames(i);
                obj.graphics.(faceName).Visible = 'off';
            end
        end
        
        function obj = ToggleVisibility(obj)
            if(obj.isVisible)
                obj = obj.Hide();
            else
                obj = obj.Show();
            end
        end

        function obj = Update(obj)
            obj = obj.UpdatePoints();
            obj = obj.UpdateGraphics();
        end

    end
end