classdef Transform < handle

    properties
        HT(4, 4) double {mustBeFinite} = eye(4);
    end

    properties (Dependent)
        Position
        RotationMatrix(3, 3) double {mustBeFinite}
        Euler
    end

    methods
        % Constructor
        function obj = Transform(HT)
            arguments
                HT(4, 4) double = [1 0 0 0; 0 1 0 0; 0 0 1 0; 0 0 0 1];
            end
            obj.HT = HT;
        end
        % Logging
        function Log(obj)
            disp("Homogeneous Transformation: ");
            disp(obj.HT);
        end
       
        %% Getters
        % Position
        function pos = get.Position(obj)
            pos.x = obj.HT(1, 4);
            pos.y = obj.HT(2, 4);
            pos.z = obj.HT(3, 4);
        end
        % Rotation matrix
        function rotmat = get.RotationMatrix(obj)
            rotmat = obj.HT(1:3, 1:3);
        end
        % Euler angles
        function euler = get.Euler(obj)
            R = obj.HT(1:3, 1:3);
            if abs(R(3, 1)) ~= 1
                theta = -asind(R(3, 1));
                psi = atan2d(R(3, 2)/cosd(theta), R(3, 3)/cosd(theta));
                phi = atan2d(R(2, 1)/cosd(theta), R(1, 1)/cosd(theta));
            else
                phi = 0;
                if R(3, 1) == -1
                    theta = 90;
                    psi = phi + atan2d(R(1, 2), R(1, 3));
                else
                    theta = -90;
                    psi = +phi + atan2d(R(1, 2), R(1, 3));
                end
            end

            euler.x = psi;
            euler.y = theta;
            euler.z = phi;
        end
   
        %% Setters
        % Position
        function set.Position(obj, pos)
            obj.HT(1, 4) = pos.x;
            obj.HT(2, 4) = pos.y;
            obj.HT(3, 4) = pos.z;
        end
        % Rotation matrix
        function set.RotationMatrix(obj, rotmat)
            arguments
                obj
                rotmat(3, 3) double {mustBeFinite};
            end
            obj.HT(1:3, 1:3) = rotmat;
        end
        % Euler angles
        function set.Euler(obj, euler)
            HT_ = rotz(euler.z)*roty(euler.y)*rotx(euler.x);
            obj.HT(1:3, 1:3) = HT_;
        end
        
        % Homogeneous transform
        function set.HT(obj, HT)
            arguments
                obj
                HT(4, 4) double {mustBeFinite};
            end
            obj.HT = HT;
        end
    end

end