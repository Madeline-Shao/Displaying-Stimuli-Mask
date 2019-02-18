%try
    clear all

    %% Load Screen

    Screen('Preference', 'SkipSyncTests', 1);
    RandStream.setGlobalStream(RandStream('mt19937ar','seed',sum(100*clock)));
    [window, rect] = Screen('OpenWindow', 0); % opening the screen
    Screen('BlendFunction', window, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA); % allowing transparency in the photos

    HideCursor();
    window_w = rect(3); % defining size of screen
    window_h = rect(4);

    x = window_w/2;
    y = window_h/2;

    crowd_dim = [window_w window_h];

    cd('Stimuli');

    %% Orange Mask

    mask = imread('mask.png'); % mask for transparency
    mask = mask(:,:,1); %use first layer % added

    %% Reading/Loading in Oranges with Noise


    tid = zeros(1,10);
    for f = 1:10;
        tmp_bmp = imread([num2str(f) '.png']); % read 10 photos
        tmp_bmp(:,:,4) = mask; % For transparency
        tid(f) = Screen('MakeTexture', window, uint8(tmp_bmp));
    end

    w_img = size(tmp_bmp, 2); %width of pictures
    h_img = size(tmp_bmp, 1); %height of pictures

    %% Displaying Orange with Large Screen Mask for Memory

    for i = 1:10
        %show orange at up left (row 1, col 1)
        Screen('DrawTexture', window, tid(i), [], ...
            [(x) (y) (x +w_img)  (y+h_img)]);
        Screen('Flip',window); % display
        WaitSecs(1); %timing of display
       % if order(i) ==1
    
        % Make and draw a interference mask texture on the whole screen as an interference mask
        % Darkness values of noise texture in each trial should be randomly
        % generated
        % Tips: "resizem" and "rand"
        mask_mem = resizem(round(rand(100))*255, [window_h, window_w]);


        mask_mem_Tex = Screen('MakeTexture', window, mask_mem);  % make the mask_memory texture
        Screen('DrawTexture', window, mask_mem_Tex); % draw the noise texture

        Screen('Flip',window);
        WaitSecs(1);

        Screen('Flip',window);
        WaitSecs(1);
    end

    Screen('CloseAll');
% catch
%     Screen('CloseAll');
%     rethrow(lasterror)
% end;
