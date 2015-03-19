function cost = psmCostFnc(x, scan, map, finalPose)
  
        T  = psm([0,0,0], scan(1:1:end,:), map(1:1:end,:), ...
            'PM_STOP_COND', x(1),                                               ...
            'PM_MAX_ITER', x(2),                                                   ...
            'PM_MAX_RANGE', 10,                                                  ...
            'PM_MIN_RANGE', .1,                                                  ...
            'PM_WEIGHTING_FACTOR', x(3),                                        ...
            'PM_SEG_MAX_DIST', x(4),                                               ...
            'PM_CHANGE_WEIGHT_ITER', x(5),                                         ...
            'PM_MAX_ERR', x(6),                                                    ...
            'PM_SEARCH_WINDOW', x(7));
        %      Rotate translation into map frame
        theta = 0;
        Trans = [ cos(theta) -sin(theta), 0; ...
            sin(theta)  cos(theta), 0; ...
            0           0           1];
        mapT  = Trans * T';
        
        
        % Add previous scan to pose
        pose = [0,0,0] + [mapT(1:2)', T(3)];
        goodPose = finalPose;
        poseErr = goodPose - pose;
        cost = abs(poseErr(1))*100 + abs(poseErr(2))*100+rad2deg(abs(poseErr(3)));
    
end