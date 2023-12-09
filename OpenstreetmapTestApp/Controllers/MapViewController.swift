//
//  ViewController.swift
//  OpenstreetmapTestApp
//
//  Created by Dmitry Gorbunow on 12/7/23.
//

import UIKit
import MapKit

// MARK: - Constants

private extension CGFloat {
    static let deltaS = 0.01
    static let deltaM = 2.0
    static let width = 50.0
}

private enum Constants {
    static let regionInMeters: CLLocationDistance = 500
}

final class MapViewController: UIViewController {
    
    // MARK: - Properties
    
    private var tileRenderer: MKTileOverlayRenderer!
    private let locationManager = CLLocationManager()
    private let viewModel: MapViewModelProtocol
    
    // MARK: - Init
    
    init(viewModel: MapViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    
    private let sheet = BottomSheetView()
    private let calloutView = CustomCalloutView()
    
    private let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private lazy var zoomPlusButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(.icZoomPlus55Dp, for: .normal)
        button.addTarget(self, action: #selector(zoomPlusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var zoomMinusButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(.icZoomMinus55Dp, for: .normal)
        button.addTarget(self, action: #selector(zoomMinusButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var myLocationButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(.icMylocation55Dp, for: .normal)
        button.addTarget(self, action: #selector(myLocationButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextTrackerButton: UIButton = {
        let button = UIButton()
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(.icNextTracker55Dp, for: .normal)
        return button
    }()
    
    private let rightButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = Offsets.m
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - ViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTileRenderer()
        setupViews()
        setupMap()
    }
    
    // MARK: - Private Methods
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        view.addSubview(mapView)
        view.addSubview(rightButtonsStackView)
        view.addSubview(sheet)
        rightButtonsStackView.addArrangedSubview(zoomPlusButton)
        rightButtonsStackView.addArrangedSubview(zoomMinusButton)
        rightButtonsStackView.addArrangedSubview(myLocationButton)
        rightButtonsStackView.addArrangedSubview(nextTrackerButton)
        sheet.isHidden = true
        sheet.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            rightButtonsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Offsets.xl),
            rightButtonsStackView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height / Sizes.dividerM),
            rightButtonsStackView.widthAnchor.constraint(equalToConstant: .width),
            rightButtonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Offsets.s),
            
            sheet.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            sheet.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sheet.widthAnchor.constraint(equalToConstant: view.frame.width),
            sheet.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: Sizes.multiplierS)
        ])
    }
    
    private func setupMap() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true
        viewModel.createAnnotations()
        mapView.addAnnotations(viewModel.annotations)
    }
    
    private func setupTileRenderer() {
        let template = "https://tile.openstreetmap.org/{z}/{x}/{y}.png"
        let overlay = MKTileOverlay(urlTemplate: template)
        overlay.canReplaceMapContent = true
        mapView.addOverlay(overlay, level: .aboveLabels)
        tileRenderer = MKTileOverlayRenderer(tileOverlay: overlay)
    }
    
    private func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: Constants.regionInMeters, longitudinalMeters: Constants.regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    
    // MARK: - @objc Methods
    
    @objc private func zoomPlusButtonTapped() {
        var region = mapView.region
        region.span.latitudeDelta /= Sizes.divider
        region.span.longitudeDelta /= Sizes.divider
        mapView.setRegion(region, animated: true)
    }
    
    @objc private func zoomMinusButtonTapped() {
        var region = mapView.region
        region.span.latitudeDelta *= Sizes.divider
        region.span.longitudeDelta *= Sizes.divider
        mapView.setRegion(region, animated: true)
    }
    
    @objc private func myLocationButtonTapped() {
        centerViewOnUserLocation()
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        return tileRenderer
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            let userLocationAnnotationView = mapView.view(for: annotation) ?? MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
            
            let image = UIImage.icMyTracker46Dp.resize(targetSize: CGSize(width: Sizes.l, height: Sizes.l))
            userLocationAnnotationView.image = image
            
            return userLocationAnnotationView
        }
        
        guard let customAnnotation = annotation as? PointAnnotation else {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: StringValues.annotationViewIdentifier.rawValue)
        
        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: StringValues.annotationViewIdentifier.rawValue)
            annotationView?.canShowCallout = false
        } else {
            annotationView?.annotation = annotation
        }
        
        let outerImage = UIImage.icTracker75Dp
        let innerImage = UIImage(named: customAnnotation.image)
        
        if let compositeImage = UIImage.createCompositeImage(outerImage: outerImage, innerImage: innerImage) {
            annotationView?.image = compositeImage
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard !(view.annotation is MKUserLocation) else { return }
        guard let annotation = view.annotation as? PointAnnotation else { return }
        
        sheet.isHidden = false
        calloutView.isHidden = false
        
        view.addSubview(calloutView)
        calloutView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calloutView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: -Offsets.m),
            calloutView.widthAnchor.constraint(equalToConstant: Sizes.xxl),
            calloutView.heightAnchor.constraint(equalToConstant: Sizes.l),
            calloutView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: view.calloutOffset.x + Sizes.xl)
        ])
        
        calloutView.configure(annotation: annotation)
        sheet.configure(annotation: annotation)
        
        let span = mapView.region.span
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        sheet.isHidden = true
        calloutView.isHidden = true
    }
}

// MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            locationManager.stopUpdatingLocation()
            render(location)
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: CGFloat.deltaS, longitudeDelta: CGFloat.deltaS)
        
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
    }
}





