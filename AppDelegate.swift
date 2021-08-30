//
//  AppDelegate.swift
//  OpsfuseFile
//
//  Created by Shaik Subhani on 28/08/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var window: UIWindow?
    static let tabBarHeight : CGFloat = 150
    static let screenHeight : CGFloat = UIScreen.main.bounds.height
    static let screenWidth : CGFloat = UIScreen.main.bounds.width
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    static let window = UIApplication.shared.windows.first(where: { (window) -> Bool in window.isKeyWindow})
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        navigationToScreen(identifier: "OnBoardViewController", storyboard: UIStoryboard(name: "OnBoard", bundle: nil))
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate {
    func createEmptyView() -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: AppDelegate.screenWidth, height: AppDelegate.screenHeight)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        return view
    }
    
    // MARK: - Navigation to particular screens
    func navigationToScreen(identifier: String, storyboard: UIStoryboard) {
        let desiredViewController = storyboard.instantiateViewController(withIdentifier: identifier)
        let navigationController = UINavigationController.init(rootViewController: desiredViewController)
        navigationController.isNavigationBarHidden = true
        navigationController.viewControllers = [desiredViewController]
        
        let snapshot:UIView = appDelegate?.window?.snapshotView(afterScreenUpdates: true) ?? createEmptyView()
        desiredViewController.view.addSubview(snapshot)
        
        
        
        if #available(iOS 13.0, *){
            if let scene = UIApplication.shared.connectedScenes.first{
                guard let windowScene = (scene as? UIWindowScene) else { return }
                let window: UIWindow = UIWindow(frame: windowScene.coordinateSpace.bounds)
                window.windowScene = windowScene
                window.rootViewController = navigationController
                window.makeKeyAndVisible()
                self.window = window
            }
        } else {
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
        
        UIView.animate(withDuration: 0.3, animations: {() in
            snapshot.layer.opacity = 0;
            snapshot.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0);
        },completion:{
            (value: Bool) in
            snapshot.removeFromSuperview();
        });
        
    }
}

