using Godot;
using System;

public class Player : Node
{
    [Export]
    public float ACCELERATION = 1200;
    [Export]
    public float FRICTION = 1200;
    [Export]
    public float MAX_SPEED = 100;

    [Signal]
    public delegate void DestinationReached(); 

    public AnimationPlayer AnimationPlayer;
    public AnimationTree AnimationTree;
    public AnimationNodeStateMachinePlayback AnimationState;
    public Sprite PlayerSprite;
    public Node2D Scene;
    public Navigation2D Nav_2D;

    public Vector2[] Path;
    public float SpeedModifier = 1.0f;
    public override void _Ready()
    {
        this.AnimationPlayer = this.GetNode<AnimationPlayer>("AnimationPlayer");
        this.AnimationTree = this.GetNode<AnimationTree>("AnimationTree");
        
    }

}
