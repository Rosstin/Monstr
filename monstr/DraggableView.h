//  DraggableView.h

#import <UIKit/UIKit.h>
#import "OverlayView.h"
#import "ProfileView.h"

@protocol DraggableViewDelegate <NSObject>

-(void)cardSwipedLeft:(UIView *)card;
-(void)cardSwipedRight:(UIView *)card;
-(void)cardTapped:(UIView *)card;

@end

@interface DraggableView : UIView

@property (weak) id <DraggableViewDelegate> delegate;

@property (nonatomic, strong)UIPanGestureRecognizer *panGestureRecognizer;
@property (nonatomic, strong)UITapGestureRecognizer *tapGestureRecognizer;
@property (nonatomic)CGPoint originalPoint;
@property (nonatomic,strong)OverlayView* overlayView;
@property (nonatomic,strong)ProfileView* profileView;
@property (nonatomic,strong)UILabel* information; //%%% a placeholder for any card-specific information

-(void)leftClickAction;
-(void)rightClickAction;

@end
