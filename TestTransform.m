t = Transform();

disp("Homogeneous Transform");
disp(t.HT);
disp("Position");
disp(t.Position);
disp("Rotation Matrix");
disp(t.RotationMatrix);
disp("Euler Angles");
disp(t.Euler);


t.Euler.z = 45;
t.Position.x = -15;
disp("Homogeneous Transform");
disp(t.HT);

t.RotationMatrix = rotz(45)*roty(25)*rotx(-15);
disp("Euler Angles");
disp(t.Euler);