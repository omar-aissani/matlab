close; clearvars; clc;
clear GameObject


tr1 = Transform([1 0 0 3; 0 1 0 -5; 0 0 1 -1; 0 0 0 1]);
tr1_1 = Transform([1 0 0 0; 0 1 0 0; 0 0 1 2; 0 0 0 1]);
tr1_2 = Transform([1 0 0 0; 0 1 0 -1; 0 0 1 0; 0 0 0 1]);

world = GameObject("World"); 
g1 = GameObject("g1");
g1_1 = GameObject("g1_1");
g1_2 = GameObject("g1_2");
g1 = g1.PushChild(g1_1);
g1 = g1.PushChild(g1_2);

g2 = GameObject("g2");
g2_1 = GameObject("g2_1");
g2_1_1 = GameObject("g2_1_1");
g2_1_2 = GameObject("g2_1_2");
g2_1 = g2_1.PushChild(g2_1_1);
g2_1 = g2_1.PushChild(g2_1_2);
g2_2 = GameObject("g2_2");
g2_3 = GameObject("g2_3");

g2 = g2.PushChild(g2_1);
g2 = g2.PushChild(g2_2);
g2 = g2.PushChild(g2_3);

g3 = GameObject("g3");
g3_1 = GameObject("g3_1");
g3_2 = GameObject("g3_2");
g3 = g3.PushChild(g3_1);
g3 = g3.PushChild(g3_2);

world = world.PushChild(g1);
world = world.PushChild(g2);
world = world.PushChild(g3);


L1 = 250; L2 = 200; L3 = 0;
q1 = 90; q2 = 0; q3 = 0;

tr = Transform(eye(4));
tr.HT(1, 4) = 0;
tr.HT(1:3, 1:3) = rotz(q1);
g2.localTransform = tr;

tr = Transform(eye(4));
tr.HT(1, 4) = L1;
tr.HT(1:3, 1:3) = rotz(q2);
g2_1.localTransform = tr;

tr = Transform(eye(4));
tr.HT(1, 4) = L2;
tr.HT(1:3, 1:3) = rotz(q3);
g2_1_1.localTransform = tr;

g2_1_1.Transform


path = [2 1 2];
node = world;
for i = 1:length(path)
    if(isempty(node.children))
        error("No more children");
    end
    node = node.children(path(i));
end
disp(node);


clearvars -except world