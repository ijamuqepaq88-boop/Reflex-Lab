import SwiftUI

struct BallDrill: Identifiable, Equatable {
    let title: String
    let subtitle: String
    let text: String
    let imageName: String
    
    var id: String { imageName }
}

extension BallDrill {
    static let all: [BallDrill] = [
        BallDrill(title: "Sole Taps",
                  subtitle: "Control the Ball with Alternating Feet",
                  text: "Gently tap the top of the ball with the sole of alternate feet, keeping the ball in place. Focus on rhythm and light touch as you begin this exercise. Stand with your feet shoulder-width apart, ensuring the ball is directly in front of you to maintain balance and control.\n\nAs you progress, use a light tapping motion to alternate between your right and left foot, establishing a steady rhythm. This helps build coordination and precision, making it an excellent warm-up or skill-building drill. Keep your movements fluid to enhance your footwork over time.\n\nWith practice, aim to increase the speed while maintaining accuracy. This drill strengthens your first touch and prepares you for more complex maneuvers. Consistency will improve your overall ball control and confidence on the field.",
                  imageName: "d1"),
        BallDrill(title: "Cone Weaving Dribble",
                  subtitle: "Zigzag Through Cones",
                  text: "Dribble the ball in a zigzag pattern through a line of cones or markers, using the inside and outside of both feet. Focus on keeping the ball close as you start this agility exercise. Set up at least five cones about two meters apart in a straight line to create a challenging path for practice.\n\nMove through the cones at a moderate pace, ensuring the ball stays within your control with each touch. Use both the inside and outside of your feet to navigate smoothly, which enhances your agility and footwork. This drill is perfect for developing quick directional changes during a game.\n\nAs you gain confidence, increase your speed while maintaining precision. This exercise improves your dribbling skills and prepares you for evading opponents. Regular practice will sharpen your reflexes and overall field performance.",
                  imageName: "d2"),
        BallDrill(title: "Wall Pass & Control",
                  subtitle: "Pass and Receive Against a Wall",
                  text: "Pass the ball against a wall and receive the rebound using your first touch to control the ball. Alternate feet for passing and receiving as you begin this drill. Stand about three meters from a solid wall, using the inside of your foot to pass and a cushioned touch to stop the rebound.\n\nFocus on passing accuracy and a soft first touch with each repetition. This helps improve your reaction time and control, making it a valuable exercise for solo practice. Alternate between feet to build versatility and strengthen both sides of your game.\n\nWith consistent practice, aim to increase the power of your passes while maintaining control. This drill enhances your ability to handle rebounds under pressure. It’s an excellent way to develop passing precision and confidence in real-game scenarios.",
                  imageName: "d3"),
        BallDrill(title: "Figure-of-Eight Dribble",
                  subtitle: "Dribble Around Two Markers",
                  text: "Set up two markers and dribble the ball in a figure-of-eight pattern around them, using both feet to start. Focus on sharp turns and ball control as you position the markers approximately three meters apart. Begin with slow, controlled touches to master the pattern.\n\nAs you improve, use both the inside and outside of your feet to navigate the figure-eight smoothly. This builds maneuverability and balance, making it a great drill for enhancing your dribbling skills. Keep the ball close to maintain control throughout the movement.\n\nIncrease your speed with practice while ensuring accuracy. This exercise prepares you for tight situations on the field and improves your agility. Regular repetition will boost your confidence in handling the ball under pressure.",
                  imageName: "d4"),
        BallDrill(title: "Inside & Outside Cuts",
                  subtitle: "Change Direction Quickly",
                  text: "Dribble forward and quickly change direction using the inside or outside of your foot to 'cut' the ball. Practice cutting left and right as you begin at a slow pace. Start with your dominant foot, using a sudden cut to shift direction and build initial control.\n\nProgress by alternating between feet to enhance your versatility. Focus on sharp changes of direction, which are crucial for evading defenders. This drill strengthens your dribbling skills and improves your ability to adapt during play.\n\nAs you gain proficiency, increase your speed while maintaining precision. This prepares you for dynamic game situations and enhances your agility. Consistent practice will make your cuts more effective and instinctive.",
                  imageName: "d5"),
        BallDrill(title: "Receiving a Ground Pass",
                  subtitle: "Control a Low Pass",
                  text: "Have a partner (or wall) pass the ball along the ground and practice receiving it with different parts of your foot. Focus on cushioning the ball with your first touch as you position yourself ready to receive. Use a relaxed foot to absorb the ball’s momentum and start building control.\n\nExperiment with the inside, outside, and sole of your foot to improve adaptability. This drill enhances your first-touch accuracy and prepares you for various pass types in a game. Repeat the process to refine your technique with each reception.\n\nWith practice, increase the speed of the passes you receive. This strengthens your ability to handle quick plays and improves your overall field readiness. Regular drills will boost your confidence in controlling the ball under pressure.",
                  imageName: "d6"),
        BallDrill(title: "Receiving a High Ball",
                  subtitle: "Control an Aerial Ball",
                  text: "Have a partner (or throw against a wall) send a ball in the air and practice controlling it with your chest, thigh, or foot. Focus on bringing the ball under control quickly as you stand with a slight bend in your knees. Use your body to direct the ball to the ground and start mastering aerial control.\n\nPractice multiple control methods to build versatility and confidence. This drill prepares you for high balls in matches and enhances your ability to handle unpredictable situations. Keep your movements fluid to improve your technique over time.\n\nAs you progress, increase the height and speed of the balls you receive. This strengthens your aerial skills and readiness for competitive play. Consistent practice will make you more adept at controlling high balls effectively.",
                  imageName: "d7"),
        BallDrill(title: "Basic Instep Kick (Low Power)",
                  subtitle: "Straight Kick with Instep",
                  text: "Place the ball still and approach slightly from the side to strike the center with your instep (shoelaces). Focus on hitting the center for a straight trajectory, not power, as you begin. Take a few steps back and use a controlled run-up to start developing your technique.\n\nStrike with the laces to ensure a straight, low shot, repeating the motion to refine your kicking accuracy. This drill builds consistency and prepares you for precise passing or shooting. Keep your focus on the ball’s center to maintain control.\n\nWith practice, gradually increase your approach speed while preserving accuracy. This enhances your ability to execute controlled kicks in games. Regular repetition will improve your kicking confidence and effectiveness on the field.",
                  imageName: "d8"),
        BallDrill(title: "Passing Through Gates",
                  subtitle: "Accurate Passes Through Targets",
                  text: "Set up pairs of markers ('gates') on the ground and practice passing the ball accurately through them. Focus on passing technique and accuracy as you arrange gates about one meter wide and five meters apart. Use the inside of your foot to pass through each gate and start building precision.\n\nAdjust the distance between you and the gates to challenge yourself further. This drill improves your passing strength and accuracy, preparing you for game situations. Repeat the passes to refine your technique with each attempt.\n\nAs you improve, increase the distance or add more gates to enhance difficulty. This strengthens your passing skills and field readiness. Consistent practice will make your passes more reliable and effective during play.",
                  imageName: "d9"),
        BallDrill(title: "Dribble Stop & Start",
                  subtitle: "Quick Stop and Accelerate",
                  text: "Dribble forward, quickly stop the ball using the sole of your foot, and then accelerate again in the same or different direction. Focus on quick stop and explosive start as you begin with a steady dribble. Use your sole to halt the ball abruptly and build initial control.\n\nPush off with a burst of speed after stopping, practicing both directions to enhance your agility. This drill improves your reaction time and prepares you for dynamic field movements. Keep the ball close during transitions to maintain mastery.\n\nIncrease your dribbling speed with practice while ensuring precise stops. This strengthens your ability to change pace in games and boosts your overall agility. Regular drills will make your stops and starts more instinctive and effective.",
                  imageName: "d10")
    ]
}
