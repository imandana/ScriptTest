#include 'shared.as'

class CCatcher : RemorseBehaviour
{
    // This is the constructor of the Object to get NativeObject
	CCatcher(CGameObj @obj)
	{
		@self = obj;
		direction = UP;
	}

    // Update is Called Once per Frame
	void Update()
	{
		const CGameObj @player = playerRef;
		if( player is null )
		{
			@player = game.FindObjByName('player');
			@playerRef = player;
		}
		int dx = 0, dy = 0;
		switch( direction )
		{
		case UP:
			if( player.get_y() < self.get_y() )
				dy--;
			else if( player.get_x() < self.get_x() )
				direction--;
			else 
				direction++;
			break;
		case RIGHT:
			if( player.get_x() > self.get_x() )
				dx++;
			else if( player.get_y() < self.get_y() )
				direction--;
			else 
				direction++;
			break;
		case DOWN:
			if( player.get_y() > self.get_y() )
				dy++;
			else if( player.get_x() > self.get_x() )
				direction--;
			else 
				direction++;
			break;
		case LEFT:
			if( player.get_x() < self.get_x() )
				dx--;
			else if( player.get_y() > self.get_y() )
				direction--;
			else 
				direction++;
			break;
		}
		
		if( direction < 0 ) direction += 4;
		if( direction > 3 ) direction -= 4;
		
		if( dx != 0 || dy != 0 )
		{
			if( !self.Move(dx,dy) )
			{
				if( player.get_x() == self.get_x() + dx && player.get_y() == self.get_y() + dy )
				{
					// Hit the player
					self.Send(CMessage('Attack'), player);
				}
				else
				{
					switch( direction )
					{
					case UP:    if( player.get_x() < self.get_x() ) direction--; else direction++; break;
					case RIGHT: if( player.get_y() < self.get_y() ) direction--; else direction++; break;
					case DOWN:  if( player.get_x() > self.get_x() ) direction--; else direction++; break;
					case LEFT:  if( player.get_y() > self.get_y() ) direction--; else direction++; break;
					}
					
					if( direction < 0 ) direction += 4;
					if( direction > 3 ) direction -= 4;
				}
			}
		}
	}
	
	CGameObj @self;
	const_weakref<CGameObj> playerRef;
	int direction;
}

enum EDirection
{
	UP,
	RIGHT,
	DOWN,
	LEFT
}

