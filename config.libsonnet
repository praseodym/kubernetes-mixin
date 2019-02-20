{
  _config+:: {
    // Selectors are inserted between {} in Prometheus queries.
    cadvisorSelector: 'job="cadvisor"',
    kubeletSelector: 'job="kubelet"',
    kubeStateMetricsSelector: 'job="kube-state-metrics"',
    nodeExporterSelector: 'job="node-exporter"',
    notKubeDnsSelector: 'job!="kube-dns"',
    kubeSchedulerSelector: 'job="kube-scheduler"',
    kubeControllerManagerSelector: 'job="kube-controller-manager"',
    kubeApiserverSelector: 'job="kube-apiserver"',
    podLabel: 'pod',
    namespaceSelector: null,
    prefixedNamespaceSelector: if self.namespaceSelector != null then self.namespaceSelector + ',' else '',
    hostNetworkInterfaceSelector: 'device!~"veth.+"',
    hostMountpointSelector: 'mountpoint="/"',
    wmiExporterSelector: 'job="wmi-exporter"',

    // We build alerts for the presence of all these jobs.
    jobs: {
      Kubelet: $._config.kubeletSelector,
      KubeScheduler: $._config.kubeSchedulerSelector,
      KubeControllerManager: $._config.kubeControllerManagerSelector,
      KubeAPI: $._config.kubeApiserverSelector,
    },

    // Grafana dashboard IDs are necessary for stable links for dashboards
    grafanaDashboardIDs: {
      'k8s-resources-cluster.json': 'ZnbvYbcXkob7GLqcDPLTj1ZL4MRX87tOh8xdr831',
      'k8s-resources-namespace.json': 'XaY4UCP3J51an4ikqtkUGBSjLpDW4pg39xe2FuxP',
      'k8s-resources-pod.json': 'wU56sdGSNYZTL3eO0db3pONtVmTvsyV7w8aadbYF',
      'k8s-cluster-rsrc-use.json': 'uXQldxzqUNgIOUX6FyZNvqgP2vgYb78daNu4GiDc',
      'k8s-node-rsrc-use.json': 'E577CMUOwmPsxVVqM9lj40czM1ZPjclw7hGa7OT7',
      'nodes.json': 'kcb9C2QDe4IYcjiTOmYyfhsImuzxRcvwWC3YLJPS',
      'pods.json': 'AMK9hS0rSbSz7cKjPHcOtk6CGHFjhSHwhbQ3sedK',
      'statefulset.json': 'dPiBt0FRG5BNYo0XJ4L0Meoc7DWs9eL40c1CRc1g',
      'k8s-resources-windows-cluster.json': '4d08557fd9391b100730f2494bccac68',
      'k8s-resources-windows-namespace.json': '490b402361724ab1d4c45666c1fa9b6f',
      'k8s-resources-windows-pod.json': '40597a704a610e936dc6ed374a7ce023',
      'k8s-windows-cluster-rsrc-use.json': '53a43377ec9aaf2ff64dfc7a1f539334',
      'k8s-windows-node-rsrc-use.json': '96e7484b0bb53b74fbc2bcb7723cd40b',
      'nodes.Windows.json': 'b9e967b479ef4ddcebd9f2fb33f19a2d',
      'pods.windows.json': '4ed0cc4adef59f4cfc27465d73d30e15',
    },

    // Config for the Grafana dashboards in the Kubernetes Mixin
    grafanaK8s: {
      dashboardNamePrefix: 'Kubernetes / ',
      dashboardTags: ['kubernetes-mixin'],

      // For links between grafana dashboards, you need to tell us if your grafana
      // servers under some non-root path.
      linkPrefix: '',
    },

    // We alert when the aggregate (CPU, Memory) quota for all namespaces is
    // greater than the amount of the resources in the cluster.  We do however
    // allow you to overcommit if you wish.
    namespaceOvercommitFactor: 1.5,
    kubeletPodLimit: 110,
    certExpirationWarningSeconds: 7 * 24 * 3600,
    certExpirationCriticalSeconds: 1 * 24 * 3600,
    cpuThrottlingPercent: 25,
    cpuThrottlingSelector: '',

    // We alert when a disk is expected to fill up in four days. Depending on
    // the data-set it might be useful to change the sampling-time for the
    // prediction
    volumeFullPredictionSampleTime: '6h',


    // This list of filesystem is referenced in various expressions.
    fstypes: ['ext[234]', 'btrfs', 'xfs', 'zfs'],
    fstypeSelector: 'fstype=~"%s"' % std.join('|', self.fstypes),

    // This list of disk device names is referenced in various expressions.
    diskDevices: ['nvme.+', 'rbd.+', 'sd.+', 'vd.+', 'xvd.+'],
    diskDeviceSelector: 'device=~"%s"' % std.join('|', self.diskDevices),
  },
}
