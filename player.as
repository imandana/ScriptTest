#include 'shared.as'

class CPlayer : RemorseBehaviour
{
    // This is the constructor of the Object to get NativeObject
	CPlayer(CGameObj @obj)
	{
		@self = obj;
	}

    // Update is Called Once per Frame
	void Update()
	{
		int dx = 0, dy = 0;
		if( game.get_actionState(UP) )
			dy--;
		if( game.get_actionState(DOWN) )
			dy++;
		if( game.get_actionState(LEFT) )
			dx--;
		if( game.get_actionState(RIGHT) )
			dx++;
		if( !self.Move(dx,dy) )
		{
		}
	}
	
    // Use this for Messaging
	void OnMessage(ref @m, const CGameObj @sender)
	{
		CMessage @msg = cast<CMessage>(m);
		if( msg !is null && msg.txt == 'Attack' )
		{
			self.Kill();
			game.EndGame(false);
		}
	}
	
	CGameObj @self;
}

enum EAction
{
	UP = 0,
	DOWN = 1,
	LEFT = 2,
	RIGHT = 3  
}
