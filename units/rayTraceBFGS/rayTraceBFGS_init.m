maskObj = Simulink.Mask.get(gcb);
camPosVecs = [];
camRotMats = [];
camDistances = [];
camIndxRefs = [];
glassNormVecs = [];
glassThicknesses = [];
imageDims =[];
camFovAngs=[];
for ii = 1:5
    tabObj = maskObj.getDialogControl(sprintf('cam%dTab',ii));
    if tabObj.Visible
        numDots = get_param(gcb,sprintf('cam%dNumDots',ii));
        numDots = max([numDots, 1]);
        numDots = round(numDots);
        
        for jj = 1:numDots
            posVec = get_param(gcb,sprintf('cam%dPosVec',ii));
            camPosVecs(:,end+1) = posVec(:);
            
            eulAngs = get_param(gcb,sprintf('cam%dPosVec',ii))*pi/180;
            rotMat  = calculateRotationMatrix(....
                eulAngs(1),eulAngs(2),eulAngs(3));
            camRotMats(:,:,end+1) = rotMat;
            
            camDistances(end+1,1) = get_param(gcb,sprintf('cam%dDist2Glass',ii))*pi/180;
            
            idxs = get_param(gcb,sprintf('cam%dIdxRef',ii))*pi/180;
            camIndxRefs(:,end+1) = idxs(:);
            
            normVec = get_param(gcb,sprintf('cam%dNormVec',ii))*pi/180;
            glassNormVecs(:,end+1) = normVec(:);
            
            glassThicknesses(end+1,1) = get_param(gcb,sprintf('cam%dGlassThick',ii));
            
            imDim = get_param(gcb,sprintf('cam%dImgDims',ii));
            imageDims(:,end+1) = round(imDim(:));
            
            fovAngs = get_param(gcb,sprintf('cam%dFoVAngs',ii));
            camFovAngs(:,end+1) = fovAngs(:);
        end
    end
end