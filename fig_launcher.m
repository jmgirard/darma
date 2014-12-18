function fig_launcher
%FIG_LAUNCHER Window to launch the other windows
% License: https://darma.codeplex.com/license

    % Create and center main window
    defaultBackground = get(0,'defaultUicontrolBackgroundColor');
    handles.figure_launcher = figure( ...
        'Units','normalized', ...
        'Position',[0.30 0.30 0.40 0.40], ...
        'Name','DARMA: Dual Axis Rating and Media Annotation', ...
        'MenuBar','none', ...
        'ToolBar','none', ...
        'NumberTitle','off', ...
        'Visible','on', ...
        'Color',defaultBackground);
    % Create UI elements
    handles.axis_title = axes(...
        'Parent',handles.figure_launcher,...
        'Units','normalized', ...
        'Position',[0.05 0.60 0.90 0.30], ...
        'Color',[0.2 0.2 0.2],...
        'Box','on','XTick',[],'YTick',[],...
        'ButtonDownFcn',@website);
    xlim([-1 1]); ylim([-1 1]);
    text(0,0,'DARMA v3.03','Color',[1 1 1],'FontSize',50,...
        'FontName','cambria','HorizontalAlignment','center',...
        'ButtonDownFcn',@website);
    %TODO: Set 'cdata' to a resized image for each button
    handles.push_collect = uicontrol('Style','pushbutton', ...
        'Parent',handles.figure_launcher, ...
        'Units','Normalized', ...
        'Position',[0.05 0.10 0.25 0.40], ...
        'String','Collect', ...
        'FontSize',18, ...
        'Callback',@push_collect_Callback);
    handles.push_review = uicontrol('Style','pushbutton', ...
        'Parent',handles.figure_launcher, ...
        'Units','Normalized', ...
        'Position',[0.05 0.10 0.25 0.40], ...
        'String','Review', ...
        'FontSize',18, ...
        'Callback',@push_review_Callback);
    handles.push_configure = uicontrol('Style','pushbutton', ...
        'Parent',handles.figure_launcher, ...
        'Units','Normalized', ...
        'Position',[0.70 0.10 0.25 0.40], ...
        'String','Configure', ...
        'FontSize',18, ...
        'Callback',@push_configure_Callback);
    align([handles.push_collect,handles.push_review,handles.push_configure],'distribute','bottom');
    guidata(handles.figure_launcher,handles);
    % Configure default settings
    global settings;
    settings.mag = 1000;
    settings.sps = 2;
    settings.folder = '';
    settings.labelX = 'Communion';
    settings.labelY = 'Agency';
    settings.label1 = 'Dominant';
    settings.label2 = 'Disagreeable';
    settings.label3 = 'Extraverted';
    settings.label4 = 'Separate';
    settings.label5 = 'Friendly';
    settings.label6 = 'Introverted';
    settings.label7 = 'Agreeable';
    settings.label8 = 'Submissive';
    % Check that VLC is installed
    axctl = actxcontrollist;
    index = strcmp(axctl(:,2),'VideoLAN.VLCPlugin.2');
    if sum(index)==0
        choice = questdlg('DARMA requires the free, open source VLC media player. Open download page?',...
            'DARMA','Yes','No','Yes');
        switch choice
            case 'Yes'
                web('http://www.videolan.org/','-browser');
        end
        delete(handles.figure_launcher);
    end
end

function push_collect_Callback(~,~)
    fig_collect;
end

function push_review_Callback(~,~)
    fig_review;
end

function push_configure_Callback(~,~)
    fig_configure();
    uiwait(findobj('Name','DARMA: Configure'));
end

function website(~,~)
    choice = questdlg('Open DARMA website in browser?','DARMA','Yes','No','Yes');
    switch choice
        case 'Yes'
            web('http://darma.codeplex.com/','-browser');
        otherwise
            return;
    end
end